// --------------------------------------------------------------------------------------------------------------------
// <copyright file="FindController.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the FindController type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.Web.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Globalization;
    using System.Linq;
    using System.Web.Http;

    using Microsoft.WindowsAzure.ServiceRuntime;

    using MongoDB.Bson;
    using MongoDB.Bson.Serialization;
    using MongoDB.Driver;
    using MongoDB.Driver.Builders;

    using TakeGive.MongoDb.Dto;

    public class FindController : ApiController
    {
        #region Fields

        private const double EarthRadius = 6378.0d; // km

        private readonly CultureInfo culture = CultureInfo.CreateSpecificCulture("en-US");

        #endregion

        // GET api/find?lat={lat}&lng={lng}&radius={radius}
        [HttpGet]
        [Route("api/find/bypoint")]
        public IEnumerable<ItemDto> FindByPoint(double lat, double lng, double radius = 2.0d)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var items = database.GetCollection<ItemDto>("item");

            var maxDistanceString = (radius / EarthRadius).ToString(this.culture.NumberFormat);
            var jsonQuery = string.Format(
                "{{ 'location' : {{ $geoWithin : {{ $centerSphere : [ [ {0} , {1} ] , {2} ] }} }} }}", 
                lat.ToString(this.culture.NumberFormat), 
                lng.ToString(this.culture.NumberFormat), 
                maxDistanceString);

            var doc = BsonSerializer.Deserialize<BsonDocument>(jsonQuery);
            var query = new QueryDocument(doc);
            var results = items.Find(query).SetLimit(20);

            var dtos = results.AsEnumerable();

            return dtos;
        }

        // GET api/find?q={q}
        [HttpGet]
        [Route("api/find/byquery")]
        public IEnumerable<ItemDto> FindByQuery(string q)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var items = database.GetCollection<ItemDto>("item");

            var queryKeywords = q
                .ToLower()
                .Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);

            var query = Query<ItemDto>.In(x => x.Keywords, queryKeywords);
            var results = items.Find(query).SetLimit(20);

            var dtos = results.AsEnumerable();

            return dtos;
        }

        // GET api/find?p=[[x1,y1],[x2,y2],[x3,y3]]
        [HttpGet]
        [Route("api/find/bypolygon")]
        public IEnumerable<ItemDto> FindByPolygon(string p)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var items = database.GetCollection<ItemDto>("item");

            var jsonQuery = "{ 'location' : { $geoWithin : { $polygon : [ " + p + " ] }}}";
            var doc = BsonSerializer.Deserialize<BsonDocument>(jsonQuery);
            var query = new QueryDocument(doc);
            var results = items.Find(query).SetLimit(20);

            var dtos = results.AsEnumerable();

            return dtos;
        }

        // GET api/find?f=[x1,y,1]&s=[x2,y2]
        [HttpGet]
        [Route("api/find/bybox")]
        public IEnumerable<FormattedItemDto> FindByBox(string f, string s)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var items = database.GetCollection<ItemDto>("item");

            // flat,flng => <bottom left coordinates>
            // slat,slng => <upper right coordinates>
            var jsonQuery = "{ 'location' : { $geoWithin : { $box : [ [ " + f + " ] , [ " + s + " ] ] }}}";
            var doc = BsonSerializer.Deserialize<BsonDocument>(jsonQuery);
            var query = new QueryDocument(doc);
            var results = items.Find(query).SetLimit(20);

            var dtos = results.Select(
                x => new FormattedItemDto()
                         {
                             Id = x.Id.ToString(),
                             Category = x.Category,
                             Description = x.Description,
                             Keywords = x.Keywords,
                             Name = x.Name,
                             Picture = x.Picture,
                             User = x.User,
                             Location = new LocationDto()
                                            {
                                                Latitude = x.Location[0],
                                                Longitude = x.Location[1]
                                            }
                         });

            return dtos;
        }

        // GET api/find?category={category}
        [HttpGet]
        [Route("api/find/bycategory")]
        public IEnumerable<ItemDto> FindByCategory(string category)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var items = database.GetCollection<ItemDto>("item");

            var query = Query<ItemDto>.EQ(x => x.Category, category);
            var results = items.Find(query).SetLimit(20);

            var dtos = results.AsEnumerable();

            return dtos;
        }

    }
}
