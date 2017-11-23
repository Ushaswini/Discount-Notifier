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
using System.Net.Http;
using Newtonsoft.Json;
using iBeaconPracticeApp.Models;
using Android.Preferences;
using EstimoteSdk;
using Android.Net;

namespace iBeaconPracticeApp
{
    [Activity(Label = "Welcome!!", MainLauncher = true, Icon = "@drawable/icon")]
    public class LoginActivity : Activity
    {
        EditText etUsername;
        EditText etPassword;
        Button btnLogin;
        Button btnRegister;
        ISharedPreferences prefs;
        ISharedPreferencesEditor prefEditor;
        ProgressDialog _progressDialog;

        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
            prefs = PreferenceManager.GetDefaultSharedPreferences(this);
            string token = prefs.GetString(Constants.AUTH_HEADER, "");
            if (!token.Equals(""))
            {
                Intent intent = new Intent(this, typeof(ProductsActivity));
                intent.SetFlags(ActivityFlags.ClearTask | ActivityFlags.NewTask);
                StartActivity(intent);
            }
            SetContentView(Resource.Layout.Login);
            Init();
        }

        protected override void OnResume()
        {
            base.OnResume();
            SystemRequirementsChecker.CheckWithDefaultDialogs(this);
        }

        private void Init()
        {
            etUsername = FindViewById<EditText>(Resource.Id.tvUsername);
            etPassword = FindViewById<EditText>(Resource.Id.tvPassword);
            btnLogin = FindViewById<Button>(Resource.Id.btnLogin);
            btnRegister = FindViewById<Button>(Resource.Id.btnRegister);
            btnRegister.Click += OnRegisterClicked;
            btnLogin.Click += OnLoginClicked;
            prefEditor = prefs.Edit();
        }

        private void OnRegisterClicked(object sender, EventArgs e)
        {
            Intent intent = new Intent(this, typeof(RegisterActivity));
            StartActivity(intent);
        }

        private async void OnLoginClicked(object sender, EventArgs e)
        {
            if (!IsInValidInput())
            {
                ConnectivityManager service = (ConnectivityManager)GetSystemService(ConnectivityService);
                NetworkInfo info = service.ActiveNetworkInfo;
                if (info != null)
                {
                    HttpClient client = new HttpClient();
                    var loginData = new LoginModel
                    {
                        UserName = etUsername.Text,
                        Password = etPassword.Text,
                        GrantType = "password"
                    };

                    try
                    {
                        HttpResponseMessage result = await client.PostAsync(Constants.LOGIN_URL, new FormUrlEncodedContent(loginData.ToDict()));

                        if (result.IsSuccessStatusCode)
                        {
                            string jsonResult = await result.Content.ReadAsStringAsync();
                            // TokenResult is a custom model class for deserialization of the Token Endpoint
                            
                            var resultObject = JsonConvert.DeserializeObject<TokenModel>(jsonResult);


                            client.DefaultRequestHeaders.Add("Authorization", "Bearer" + resultObject.Access_Token);
                            var profile = await client.GetAsync(Constants.GETUSERINFO_URL);

                            var jsonProfile = await profile.Content.ReadAsStringAsync();


                            prefEditor.PutString(Constants.AUTH_HEADER, "Bearer" + resultObject.Access_Token);
                            prefEditor.PutString(Constants.USER_PROFILE, jsonProfile);
                            prefEditor.Apply();

                            //move to discount page
                            Intent intent = new Intent(this, typeof(ProductsActivity));
                            intent.SetFlags(ActivityFlags.ClearTask | ActivityFlags.NewTask);
                            StartActivity(intent);

                        }
                        else
                        {
                            Toast.MakeText(this, result.ReasonPhrase, ToastLength.Short).Show();
                        }
                    }
                    catch (Exception ex)
                    {
                        string debugBreak = ex.ToString();
                        Toast.MakeText(this, debugBreak, ToastLength.Short).Show();
                    }
                }
                else
                {
                    Toast.MakeText(this, "Invalid inputs", ToastLength.Short).Show();
                }
            }
            else
            {
                //Snackbar snackBar = Snackbar.Make((Button)sender, "No nternet Connection", Snackbar.LengthIndefinite);
                //Show the snackbar
                //snackBar.Show();
            }
        }

        private bool IsInValidInput()
        {
            bool isInvalid = false;

            
            if (etPassword.Text == null)
            {
                isInvalid = true;
                etPassword.Error = "Password cannot be empty";
            }
            if (etUsername.Text == null)
            {
                isInvalid = true;
                etUsername.Error = "User name cannot be empty";
            }
            
            return isInvalid;

        }
        private void ShowProgress(string message)
        {
            _progressDialog = new ProgressDialog(this);
            _progressDialog.SetMessage(message);
            _progressDialog.SetProgressStyle(ProgressDialogStyle.Spinner);
            _progressDialog.SetCancelable(false);
            _progressDialog.Show();
        }

        private void EndProgress()
        {
            _progressDialog.Dismiss();
        }
    }
}