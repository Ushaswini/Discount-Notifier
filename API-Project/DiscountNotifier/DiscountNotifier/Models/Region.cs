using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DiscountNotifier.Models
{
    public class Region
    {
        public int RegionId { get; set; }
        public string RegionName { get; set; }
        public string BeaconId { get; set; }
        public string StoreKeeperName { get; set; }
        
    }
}