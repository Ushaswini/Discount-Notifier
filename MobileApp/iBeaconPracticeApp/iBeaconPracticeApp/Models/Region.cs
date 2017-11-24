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

namespace iBeaconPracticeApp.Models
{
    public class BeaconRegion
    {
        public int RegionId { get; set; }
        public string RegionName { get; set; }
        public string BeaconId { get; set; }
        public string StoreKeeperName { get; set; }

        public override string ToString()
        {
            return RegionName + " - " + StoreKeeperName;
        }

    }
    public class RegionIdModel
    {
        public int RegionId { get; set; }
        public string UserId { get; set; }

        public Dictionary<string, string> ToDict()
        {

            Dictionary<string, string> parameters = new Dictionary<string, string>();

            parameters.Add("RegionId", this.RegionId.ToString());
            parameters.Add("UserId", this.UserId);
            

            return parameters;
        }
    }
}