// --------------------------------------------------------------------------------------------------------------------
// <copyright file="StoreDto.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the StoreDto type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb.Dto
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;

    public class StoreDto
    {
        [BsonId(Order = 0)]
        public ObjectId Id { get; set; }

        [BsonElement("name", Order = 1)]
        public string Name { get; set; }

        [BsonElement("picture", Order = 2), BsonIgnoreIfDefault]
        public string Picture { get; set; }

        [BsonElement("description", Order = 3), BsonIgnoreIfDefault]
        public string Description { get; set; }
    }
}