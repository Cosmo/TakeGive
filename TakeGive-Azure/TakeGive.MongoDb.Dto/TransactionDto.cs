// --------------------------------------------------------------------------------------------------------------------
// <copyright file="TransactionDto.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the TransactionDto type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb.Dto
{
    using MongoDB.Bson;
    using MongoDB.Bson.Serialization.Attributes;

    public class TransactionDto
    {
        [BsonId(Order = 0)]
        public ObjectId Id { get; set; }

        [BsonElement("userGiving", Order = 1)]
        public UserDto UserGiving { get; set; }

        [BsonElement("userTaking", Order = 2)]
        public UserDto UserTaking { get; set; }

        [BsonElement("item", Order = 3)]
        public ItemDto Item { get; set; }
    }
}