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

    public class UserDto
    {
        [BsonId(Order = 0)]
        public ObjectId Id { get; set; }

        [BsonElement("name", Order = 1)]
        public string Name { get; set; }

        [BsonElement("picture", Order = 2), BsonIgnoreIfDefault]
        public string Picture { get; set; }
    }
}
