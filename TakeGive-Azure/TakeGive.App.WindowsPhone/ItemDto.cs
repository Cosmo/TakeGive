using System.Collections.Generic;

namespace TakeGive.App.WindowsPhone
{
    using Newtonsoft.Json;

    public class ItemDto
    {
        [JsonProperty(PropertyName = "_id")]
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
        public double[] Location { get; set; }

        [JsonProperty(PropertyName = "name")]
        public string Name { get; set; }
    }
}
