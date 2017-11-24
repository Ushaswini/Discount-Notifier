using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DiscountNotifier.Models
{
    public class Discount
    {
        public int Id { get; set; }

        //Foregin key for region
        public int RegionId { get; set; }
        public string OfferText { get; set; }
        public string Price { get; set; }
        public decimal DiscountPercent { get; set; }
        public string ImageUrl { get; set; }

        //Navigation property
        public Region Region { get; set; }
       

    }

    public class DiscountPushNotification
    {
        [JsonProperty(propertyName: "registration_ids")]
        public List<string> RegisteredDeviceIds { get; set; }
        [JsonProperty(propertyName: "notification")]
        public PushNotificationData Data { get; set; }
    }

    public class PushNotificationData
    {
        [JsonProperty(propertyName: "title")]
        public string Message { get; set; }
        [JsonProperty(propertyName: "body")]
        public string Time { get; set; }
    }
}