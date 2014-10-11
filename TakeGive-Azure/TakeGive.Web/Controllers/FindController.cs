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
    using System.Collections.Generic;
    using System.Globalization;
    using System.Linq;
    using System.Web.Http;

    using Microsoft.WindowsAzure.ServiceRuntime;

    using MongoDB.Bson;
    using MongoDB.Bson.Serialization;
    using MongoDB.Driver;

    using TakeGive.MongoDb.Dto;

    public class FindController : ApiController
    {
        private const double EarthRadius = 6378.0d; // km

        private readonly CultureInfo culture = CultureInfo.CreateSpecificCulture("en-US");

        // GET api/find?lat={lat}&lng={lng}&radius={radius}
        public IEnumerable<GiveAwayDto> Get(double lat, double lng, double radius = 2.0d)
        {
            var connectionString = RoleEnvironment.GetConfigurationSettingValue("MongoDbConnectionString");
            var database = MongoDatabase.Create(connectionString);
            var giveAways = database.GetCollection<GiveAwayDto>("giveaway");

            var maxDistanceString = (radius / EarthRadius).ToString(this.culture.NumberFormat);
            var jsonQuery = string.Format(
                "{{ 'location' : {{ $geoWithin : {{ $centerSphere : [ [ {0} , {1} ] , {2} ] }} }} }}", 
                lng.ToString(this.culture.NumberFormat), 
                lat.ToString(this.culture.NumberFormat), 
                maxDistanceString);

            var doc = BsonSerializer.Deserialize<BsonDocument>(jsonQuery);
            var query = new QueryDocument(doc);
            var results = giveAways.Find(query)
                //.SetSortOrder(new SortByBuilder().Descending("publishedAt"))
                .SetLimit(50);

            var dtos = results.AsEnumerable();

            return dtos;
        }
    }
}
