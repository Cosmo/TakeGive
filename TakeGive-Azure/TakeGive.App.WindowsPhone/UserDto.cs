namespace TakeGive.App.WindowsPhone
{
    using Newtonsoft.Json;

    public class UserDto
    {
        [JsonProperty(PropertyName = "id")]
        public string Id { get; set; }

        [JsonProperty(PropertyName = "name")]
        public string Name { get; set; }

        [JsonProperty(PropertyName = "picture")]
        public string Picture { get; set; }
    }
}