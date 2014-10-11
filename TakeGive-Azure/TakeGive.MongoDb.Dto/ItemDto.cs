// --------------------------------------------------------------------------------------------------------------------
// <copyright file="ItemDto.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the ItemDto type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb.Dto
{
    using System.Collections.Generic;

    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;

    using Newtonsoft.Json;

    public class ItemDto
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

        [JsonProperty(PropertyName = "keywords")]
        [BsonElement("keywords", Order = 4)]
        public IEnumerable<string> Keywords { get; set; }

        [JsonProperty(PropertyName = "category")]
        [BsonElement("category", Order = 5)]
        public string Category { get; set; }

        [JsonProperty(PropertyName = "location")]
        [BsonElement("location", Order = 6)]
        public double[] Location { get; set; }

        [JsonProperty(PropertyName = "name")]
        [BsonElement("name", Order = 7)]
        public string Name { get; set; }
    }
}