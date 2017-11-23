using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Newtonsoft.Json;

namespace iBeaconPracticeApp.Models
{
    public class Product
    {
        string _discount,_imageUrl,_name,_price,_region;
        int _regionId;

        [JsonProperty("DiscountPercent")]
        public string Discount { get => _discount; set => _discount = value; }
        [JsonProperty("ImageUrl")]
        public string ImageUrl { get => _imageUrl; set => _imageUrl = value; }
        [JsonProperty("OfferText")]
        public string Name { get => _name; set => _name = value; }
        [JsonProperty("Price")]
        public string Price { get => _price; set => _price = value; }
        [JsonProperty("RegionId")]
        public int RegionId { get => _regionId; set => _regionId = value; }
        public string Region {
            get
            {
                string region = "";
                switch (_regionId)
                {
                    case 1: region= "Produce";break;
                    case 2: region = "Grocery";break;
                    case 3: region = "Lifestyle";break;
                }
                return region;
            }
        }
    }
}