// --------------------------------------------------------------------------------------------------------------------
// <copyright file="GiveAwayDto.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the GiveAwayDto type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb.Dto
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;

    using Newtonsoft.Json;

    public class GiveAwayDto
    {
        [JsonProperty(PropertyName = "id")]
        [BsonId(Order = 0)]
        public ObjectId Id { get; set; }

        [JsonProperty(PropertyName = "user")]
        [BsonElement("user", Order = 1)]
        public UserDto User { get; set; }

        [JsonProperty(PropertyName = "picture")]
        [BsonElement("picture", Order = 2), BsonIgnoreIfDefault]
        public string Picture { get; set; }

        [JsonProperty(PropertyName = "description")]
        [BsonElement("description", Order = 3), BsonIgnoreIfDefault]
        public string Description { get; set; }
    }
}