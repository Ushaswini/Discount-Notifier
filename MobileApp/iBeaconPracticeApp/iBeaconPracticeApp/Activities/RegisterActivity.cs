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
using Android.Net;
using iBeaconPracticeApp.Models;
using System.Net.Http;
using Android.Util;

namespace iBeaconPracticeApp
{
    [Activity(Label = "RegisterActivity")]
    public class RegisterActivity : Activity
    {
        EditText etFullname;
        EditText etUsername;
        EditText etPassword;
        EditText etConfirmPassword;
        EditText etEmail;
        Button btnRegister;
        ProgressDialog _progressDialog;

        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
            SetContentView(Resource.Layout.Register);
            Initialize();
            // Create your application here
        }

        private void Initialize()
        {
            etFullname = FindViewById<EditText>(Resource.Id.tvFullname);
            etUsername = FindViewById<EditText>(Resource.Id.tvUsername);
            etPassword = FindViewById<EditText>(Resource.Id.tvPassword);
            etEmail = FindViewById<EditText>(Resource.Id.tvEmail);
            etConfirmPassword = FindViewById<EditText>(Resource.Id.tvConfirmPassword);
            btnRegister = FindViewById<Button>(Resource.Id.btnRegister);
            btnRegister.Click += OnRegisterClickedAsync;
        }

        private async void OnRegisterClickedAsync(object sender, EventArgs e)
        {
            string fullName = etFullname.Text;
            string email = etEmail.Text;
            string userName = etUsername.Text;
            string password = etPassword.Text;
            string confirmPassword = etConfirmPassword.Text;

            if (!IsInValidInput())
            {
                ConnectivityManager service = (ConnectivityManager)GetSystemService(ConnectivityService);
                NetworkInfo info = service.ActiveNetworkInfo;
                if (info != null)
                {
                    ShowProgress("Working...");
                    var user = new RegisterUserModel
                    {
                        UserName = userName,
                        FullName = fullName,
                        Email = email,
                        Password = password,
                        ConfirmPassword = confirmPassword
                    };

                    using (var client = new HttpClient())
                    {
                        client.DefaultRequestHeaders.Accept.Clear();
                        HttpResponseMessage result = await client.PostAsync(Constants.REGISTERUSER_URL, new FormUrlEncodedContent(user.ToDict()));

                        if (result.IsSuccessStatusCode)
                        {
                            Toast.MakeText(this, "Registration Successful", ToastLength.Short).Show();
                            //Intent GoBackToLogin = new Intent(this, typeof(LoginActivity));
                            //StartActivity(GoBackToLogin);
                            EndProgress();
                            Finish();
                        }
                        else
                        {
                            EndProgress();
                            Toast.MakeText(this, "Registration NOT Successful", ToastLength.Short).Show();
                            Log.Debug(Constants.TAG, "Error occured");
                        }
                    }
                }
                else
                {
                    //Snackbar snackBar = Snackbar.Make((Button)sender, "No nternet Connection", Snackbar.LengthIndefinite);
                    //Show the snackbar
                    //snackBar.Show();
                }
            }
        }

            private bool IsInValidInput()
            {
                bool isInvalid = false;

                if (etFullname.Text == null)
                {
                    isInvalid = true;
                    etFullname.Error = "Full name cannot be empty";
                }
                if (etEmail.Text == null)
                {
                    isInvalid = true;
                    etEmail.Error = "Email cannot be empty";
                }
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
                if (etConfirmPassword.Text == null)
                {
                    isInvalid = true;
                    etConfirmPassword.Error = "Confirm Password cannot be empty";
                }

                if (!etPassword.Text.Equals(etConfirmPassword.Text))
                {
                    isInvalid = true;
                    etPassword.Error = "Passwords must match!";
                    etConfirmPassword.Error = "Passwords must match!";
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
