using System;
using Android.App;
using Firebase.Iid;
using Android.Util;
using Android.Content;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using iBeaconPracticeApp.Models;
using Android.Preferences;

namespace iBeaconPracticeApp
{
    [Service]
    [IntentFilter(new[] { "com.google.firebase.INSTANCE_ID_EVENT" })]
    public class MyFirebaseIIDService : FirebaseInstanceIdService
    {
        const string TAG = "MyFirebaseIIDService";
        ISharedPreferences prefs;
        ISharedPreferencesEditor prefEditor;
        public override void OnTokenRefresh()
        {
            prefs = PreferenceManager.GetDefaultSharedPreferences(this);
            
            var refreshedToken = FirebaseInstanceId.Instance.Token;
            Log.Debug(TAG, "Refreshed token: " + refreshedToken);
            SendRegistrationToServer(refreshedToken);
        }

        void SendRegistrationToServer(string token)
        {
            // string userId = prefs.GetString(Constants.USERID, "");
            string deviceId = prefs.GetString(Constants.DEVICEID, "");

            if (!deviceId.Equals(token))
            {
                prefEditor = prefs.Edit();
                prefEditor.PutString(Constants.DEVICEID, token);
                prefEditor.Apply();
                // Add custom implementation, as needed.

            }


        }
    }
    }