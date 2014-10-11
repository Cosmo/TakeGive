// --------------------------------------------------------------------------------------------------------------------
// <copyright file="UserDto.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the UserDto type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb.Dto
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;

    using Newtonsoft.Json;

    public class UserDto
    {
        [JsonProperty(PropertyName = "id")]
        [BsonId(Order = 0)]
        public ObjectId Id { get; set; }

        [JsonProperty(PropertyName = "name")]
        [BsonElement("name", Order = 1)]
        public string Name { get; set; }

        [JsonProperty(PropertyName = "picture")]
        [BsonElement("picture", Order = 2), BsonIgnoreIfDefault]
        public string Picture { get; set; }
    }
}
