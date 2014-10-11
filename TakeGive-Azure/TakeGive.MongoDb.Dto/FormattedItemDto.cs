// --------------------------------------------------------------------------------------------------------------------
// <copyright file="FormattedItemDto.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the FormattedItemDto type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb.Dto
{
    using System.Collections.Generic;

    using Newtonsoft.Json;

    public class FormattedItemDto
    {
        [JsonProperty(PropertyName = "id")]
        public string Id { get; set; }

        [JsonProperty(PropertyName = "user")]
        public UserDto User { get; set; }

        [JsonProperty(PropertyName = "picture")]
        public string Picture { get; set; }

        [JsonProperty(PropertyName = "description")]
        public string Description { get; set; }

        [JsonProperty(PropertyName = "keywords")]
        public IEnumerable<string> Keywords { get; set; }

        [JsonProperty(PropertyName = "category")]
        public string Category { get; set; }

        [JsonProperty(PropertyName = "location")]
        public LocationDto Location { get; set; }

        [JsonProperty(PropertyName = "name")]
        public string Name { get; set; }
    }
}