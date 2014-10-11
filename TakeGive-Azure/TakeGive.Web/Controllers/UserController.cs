// --------------------------------------------------------------------------------------------------------------------
// <copyright file="UserController.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the UserController type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.Web.Controllers
{
    using System.Web.Http;

    using Microsoft.WindowsAzure.ServiceRuntime;

    using MongoDB.Driver;

    using TakeGive.MongoDb.Dto;

    public class UserController : ApiController
    {
        // POST: api/user
        [Route("api/user")]
        public UserDto Post(string name)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var users = database.GetCollection<UserDto>("user");

            var dto = new UserDto() { Name = name };
            var result = users.Save(dto);

            return dto;
        }
    }
}