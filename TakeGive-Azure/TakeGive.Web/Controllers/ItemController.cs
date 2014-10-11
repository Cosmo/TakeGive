// --------------------------------------------------------------------------------------------------------------------
// <copyright file="ItemController.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the ItemController type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.Web.Controllers
{
    using System;
    using System.Diagnostics;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Net.Http;
    using System.Threading.Tasks;
    using System.Web;
    using System.Web.Http;

    using Microsoft.WindowsAzure.ServiceRuntime;
    using Microsoft.WindowsAzure.Storage;

    using MongoDB.Bson;
    using MongoDB.Driver;
    using MongoDB.Driver.Builders;

    using TakeGive.MongoDb.Dto;

    public class ItemController : ApiController
    {
        // POST: api/item
        [Route("api/item")]
        public ItemDto Post(string userId, string name, double lat, double lng, string description, string category)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var users = database.GetCollection<UserDto>("user");
            var items = database.GetCollection<ItemDto>("item");

            var keywords = name
                .ToLower()
                .Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

            var userDto = users.FindOne(Query<UserDto>.EQ(x => x.Id, new ObjectId(userId)));
            var itemDto = new ItemDto()
                {
                    Id = new ObjectId(),
                    Name = name,
                    Location = new[] { lat, lng },
                    Description = description,
                    Keywords = keywords,
                    User = userDto,
                    Category = category
                };

            var result = items.Save(itemDto);

            return itemDto;
        }

        // POST: api/item/{id}/picture
        [Route("api/item/{id}/picture")]
        public async Task<ItemDto> Post(string id)
        {
            // Check if the request contains multipart/form-data.
            if (!Request.Content.IsMimeMultipartContent()) 
                throw new HttpResponseException(HttpStatusCode.UnsupportedMediaType);

            string root = HttpContext.Current.Server.MapPath("~/App_Data");
            var provider = new MultipartFormDataStreamProvider(root);

            await Request.Content.ReadAsMultipartAsync(provider);
            var file = provider.FileData.FirstOrDefault();
            if (file == null) throw new HttpException("no file uploaded.");

            byte[] bytes = File.ReadAllBytes(file.LocalFileName);
            var pictureUrl = this.UploadImageToBlobStorage(bytes, file.Headers.ContentType.MediaType);

            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var items = database.GetCollection<ItemDto>("item");

            var dto = items.FindOne(Query<ItemDto>.EQ(x => x.Id, new ObjectId(id)));
            if (dto == null) throw new HttpException("unknown item.");

            dto.Picture = pictureUrl;
            var result = items.Save(dto);

            return dto;
        }

        private string UploadImageToBlobStorage(byte[] bytes, string contentType)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("StorageConnectionString");
            var storageAccount = CloudStorageAccount.Parse(connectionString);
            var blobClient = storageAccount.CreateCloudBlobClient();

            var uniqueBlobName = string.Format("{0}.jpg", Guid.NewGuid());
            var blob = blobClient.GetContainerReference("images").GetBlockBlobReference(uniqueBlobName);
            blob.Properties.ContentType = contentType;
            blob.UploadFromByteArray(bytes, 0, bytes.Length);

            return blob.Uri.AbsoluteUri;
        }
    }
}
