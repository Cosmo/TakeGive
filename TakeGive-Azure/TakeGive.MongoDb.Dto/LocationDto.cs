// --------------------------------------------------------------------------------------------------------------------
// <copyright file="LocationDto.cs" company="TakeGive.eu">
//   TakeGive.eu
// </copyright>
// <summary>
//   Defines the LocationDto type.
// </summary>
// --------------------------------------------------------------------------------------------------------------------

namespace TakeGive.MongoDb.Dto
{
    using Newtonsoft.Json;

    public class LocationDto
    {
        [JsonProperty(PropertyName = "lat")]
        public double Latitude { get; set; }

        [JsonProperty(PropertyName = "lng")]
        public double Longitude { get; set; }
    }
}