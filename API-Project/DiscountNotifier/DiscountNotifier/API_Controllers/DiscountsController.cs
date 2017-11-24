using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

using DiscountNotifier.Models;
using Newtonsoft.Json;
using System.IO;
using System.Text;
using DiscountNotifier.DTOs;

namespace DiscountNotifier.Controllers
{
    [RoutePrefix("api/Discounts")]
    public class DiscountsController : ApiController
    {
        public static String AUTH_KEY_FCM = "Your api key";
        public static String API_URL_FCM = "https://fcm.googleapis.com/fcm/send";

        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: api/Discounts
        public IQueryable<Discount> GetDiscounts()
        {
            return db.Discounts;
        }

        //GET: api/Discounts/Region/1
        public IQueryable<Discount> GetDiscountsForRegionName(string regionName)
        {
            var id = (from r in db.Regions where r.RegionName == regionName select r.RegionId).FirstOrDefault();
            var result = from d in db.Discounts where d.RegionId.Equals(id) select d;
            return result;
        }

        public IList<DiscountDTO> GetDiscountsForRegionId(int regionId)
        {
            var result = db.Discounts.Include(d => d.Region).Where(d => d.RegionId == regionId).Select(d => new DiscountDTO
            {
                Id = d.Id,
                RegionId = d.RegionId,
                Price = d.Price,
                ImageUrl = d.ImageUrl,
                DiscountPercent = d.DiscountPercent,
                BeaconId = d.Region.BeaconId,
                StoreKeeperName = d.Region.StoreKeeperName,
                OfferText = d.OfferText,
                RegionName = d.Region.RegionName
            }).ToList();
            //var result = from d in db.Discounts where d.RegionId.Equals(regionId) select d;
            return result;
        }

        // GET: api/Discounts/5
        [ResponseType(typeof(Discount))]
        public async Task<IHttpActionResult> GetDiscount(int id)
        {
            Discount discount = await db.Discounts.FindAsync(id);
            
            if (discount == null)
            {
                return NotFound();
            }

            return Ok(discount);
        }

        // PUT: api/Discounts/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutDiscount(int id, Discount discount)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != discount.Id)
            {
                return BadRequest();
            }

            db.Entry(discount).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DiscountExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Discounts
        [ResponseType(typeof(Discount))]
        public async Task<IHttpActionResult> PostDiscount(Discount discount)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Discounts.Add(discount);
            await db.SaveChangesAsync();

            var dis = db.Discounts.Include(d => d.Region).Where(d => d.Id.Equals(discount.Id)).FirstOrDefault();

            SendNotification(dis);
            

            return CreatedAtRoute("DefaultApi", new { id = discount.Id }, discount);
        }

        private void SendNotification(Discount discount)
        {
            try
            {
                List<string> deviceIds = new List<string>();
                var usersRegistered = db.Users.Where(u => u.RegionId == discount.RegionId);
                foreach (var user in usersRegistered)
                {
                    if (user.DeviceId != null)
                        deviceIds.Add(user.DeviceId);
                }
              
                DiscountPushNotification notification = new DiscountPushNotification
                {
                    RegisteredDeviceIds = deviceIds,
                    Data = new PushNotificationData
                    {
                        Message = discount.OfferText,
                        Time = "Prices as low as " + discount.Price + " $ with "+ discount.DiscountPercent + "%" + "  discount at " + discount.Region.RegionName
                    }

                };
                if (deviceIds.Count > 0)
                {
                    
                    var applicationID = "AIzaSyBz8_qqXaVpZqj1B0FJJy1cemcXJmAUA7s";
                    // applicationID means google Api key 
                    var SENDER_ID = "1008556843671";
                    // SENDER_ID is nothing but your ProjectID (from API Console- google code)  

                    string serializedNotification = JsonConvert.SerializeObject(notification);

                    WebRequest tRequest;

                    tRequest = WebRequest.Create(API_URL_FCM);

                    tRequest.Method = "post";

                    tRequest.ContentType = " application/json";

                    tRequest.Headers.Add(string.Format("Authorization: key={0}", applicationID));

                    tRequest.Headers.Add(string.Format("Sender: id={0}", SENDER_ID));

                    Byte[] byteArray = Encoding.UTF8.GetBytes(serializedNotification);
                    tRequest.ContentLength = byteArray.Length;
                    Stream dataStream = tRequest.GetRequestStream();
                    dataStream.Write(byteArray, 0, byteArray.Length);
                    dataStream.Close();
                    WebResponse tResponse = tRequest.GetResponse();
                    dataStream = tResponse.GetResponseStream();
                    StreamReader tReader = new StreamReader(dataStream);
                    String sResponseFromServer = tReader.ReadToEnd();   //Get response from GCM server.
                    Console.WriteLine(sResponseFromServer);
                    tReader.Close();
                    dataStream.Close();
                    tResponse.Close();
                }
            }
            catch (Exception e)
            {

            }
        }

        // DELETE: api/Discounts/5
        [ResponseType(typeof(Discount))]
        public async Task<IHttpActionResult> DeleteDiscount(int id)
        {
            Discount discount = await db.Discounts.FindAsync(id);
            if (discount == null)
            {
                return NotFound();
            }

            db.Discounts.Remove(discount);
            await db.SaveChangesAsync();

            return Ok(discount);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool DiscountExists(int id)
        {
            return db.Discounts.Count(e => e.Id == id) > 0;
        }
    }
}