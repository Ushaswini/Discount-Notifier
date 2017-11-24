using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DiscountNotifier.DTOs
{
    public class DiscountDTO
    {
        public int Id { get; set; }

        //Foregin key for region
        public int RegionId { get; set; }
        public string OfferText { get; set; }
        public string Price { get; set; }
        public decimal DiscountPercent { get; set; }
        public string ImageUrl { get; set; }

        public string RegionName { get; set; }
        public string BeaconId { get; set; }
        public string StoreKeeperName { get; set; }
    }
}