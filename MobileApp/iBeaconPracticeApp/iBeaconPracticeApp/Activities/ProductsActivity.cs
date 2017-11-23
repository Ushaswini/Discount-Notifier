using Android.App;
using Android.Widget;
using Android.OS;
using EstimoteSdk;
using System.Net.Http;
using Newtonsoft.Json;
using iBeaconPracticeApp.Models;
using System.Collections.Generic;
using System.Threading.Tasks;
using static EstimoteSdk.Utils;
using System;
using System.Linq;
using Android.Util;

namespace iBeaconPracticeApp
{
    [Activity(Label ="Discounts!")]
    public class ProductsActivity : Activity, BeaconManager.IServiceReadyCallback
    {
        BeaconManager _beaconManager;
        Region _regionProduce;
        Region _regionGrocery;
        Region _regionLifeStyle;
        Region _regionBeacon;

        Proximity _proximity;
        double _distance,_currentBeaconDistance;
        long _lastActiveTime;
        Beacon _currentBeacon;

        ListView lv;
        List<Product> Products;
        ProductsAdapter adapter;

        protected async override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            // Set our view from the "main" layout resource
            SetContentView (Resource.Layout.Main);

            Init();

            await GetDataAsync("");

        }        

        protected override void OnResume()
        {
            base.OnResume();
            SystemRequirementsChecker.CheckWithDefaultDialogs(this);
            _beaconManager.Connect(this);
        }

        public void OnServiceReady()
        {
            // This method is called when BeaconManager is up and running.
            _beaconManager.StartRanging(_regionGrocery);
            _beaconManager.StartRanging(_regionLifeStyle);
            _beaconManager.StartRanging(_regionProduce);
            _beaconManager.StartMonitoring(_regionBeacon);

        }

        protected override void OnDestroy()
        {
            base.OnDestroy();
            // Make sure we disconnect from the Estimote.
            _beaconManager.Disconnect();
        }

        protected void InitilizeRegions()
        {
            _regionBeacon = new Region(Constants.DISCOUNT_REGION_IDENTIFIER, "B9407F30-F5F8-466E-AFF9-25556B57FE6D");
            _regionGrocery = new Region(Constants.GROCERY_IDENTIFIER, "B9407F30-F5F8-466E-AFF9-25556B57FE6D", 15212, 31506);
            _regionLifeStyle = new Region(Constants.LIFESTYLE_IDENTIFIER, "B9407F30-F5F8-466E-AFF9-25556B57FE6D", 48071, 25324);
            _regionProduce = new Region(Constants.PRODUCE_IDENTIFIER, "B9407F30-F5F8-466E-AFF9-25556B57FE6D", 26535, 44799);
       
        }

        protected  void Init()
        {
            // GetDataAsync("");

            lv = FindViewById<ListView>(Resource.Id.listView);

            Products = new List<Product>();

            adapter = new ProductsAdapter(this, Products);

            lv.Adapter = adapter;

            InitilizeRegions();

            _beaconManager = new BeaconManager(this);

            _beaconManager.SetForegroundScanPeriod(150, 2000);

            _beaconManager.Ranging += OnRanging;

            _beaconManager.ExitedRegion += OnExitedRegion;
        }

        private async void OnRanging(object sender, BeaconManager.RangingEventArgs e)
        {
            Log.Debug("demo", "IN Ranging " + e.Beacons.Count);
            if (e.Beacons.Count > 0)
            {
                Log.Debug("demo", "List > 0");

                foreach (Beacon beacon in e.Beacons)
                {

                    _proximity = ComputeProximity(beacon);
                    if (_proximity != Proximity.Unknown)
                    {
                        _distance = ComputeAccuracy(beacon);
                        _lastActiveTime = new DateTime().Ticks;

                        //If distance is valid and (less than current distance or current beacon is null) update current beacon
                        if (_distance > -1 && ((_distance < _currentBeaconDistance) || _currentBeacon == null))
                        {

                            _currentBeaconDistance = _distance;
                            _currentBeacon = beacon;
                        }
                        //If distance is valid and beacon major is same as current beacon's major, update current beacon distance
                        if (_distance > -1 && (beacon.Major == _currentBeacon.Major))
                        {
                            _currentBeaconDistance = _distance;
                        }

                        if (_currentBeacon != null)
                        {
                            //Log.Debug("demo", _currentBeacon.Major.ToString());
                            await GetDataAsync(_currentBeacon.Major.ToString());
                        }
                    }
                }
            }
            else
            {
                if (((new DateTime()).Ticks - _lastActiveTime) > 8300)
                {
                    await GetDataAsync("");
                }
                _lastActiveTime = (new DateTime()).Ticks;
            }

        }

        private async void OnExitedRegion(object sender, BeaconManager.ExitedRegionEventArgs e)
        {
            await GetDataAsync("");
        }

        protected async Task GetDataAsync(string majorIdentifier)
        {
            try
            {
                string url = "";
                string message = "";
                if (majorIdentifier.Equals("15212"))
                {
                    url = string.Format(Constants.REGION_URL, Constants.GROCERY_IDENTIFIER);
                    message = Constants.GROCERY_IDENTIFIER;
                }
                else if (majorIdentifier.Equals("48071"))
                {
                    url = string.Format(Constants.REGION_URL, Constants.LIFESTYLE_IDENTIFIER);
                    message = Constants.LIFESTYLE_IDENTIFIER;
                }
                else if (majorIdentifier.Equals("26535"))
                {
                    url = string.Format(Constants.REGION_URL, Constants.PRODUCE_IDENTIFIER);
                    message = Constants.PRODUCE_IDENTIFIER;
                }
                else
                {
                    url = Constants.ALL_URL;
                    message = "All items";
                }

                Toast.MakeText(this, message, ToastLength.Short).Show();

                HttpClient client = new HttpClient();
                var data = await client.GetStringAsync(url);
                var products = JsonConvert.DeserializeObject<List<Product>>(data);
                products = products.OrderBy(i => i.RegionId).ToList();

                RunOnUiThread(() => {
                    adapter.UpdateData(products);
                });
            }catch(Exception e)
            {
                Log.Error("demo", e.Message);
            }
            
            
        }
    }
}

