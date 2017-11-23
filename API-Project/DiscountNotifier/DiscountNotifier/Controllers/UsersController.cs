using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using DiscountNotifier.Models;
using DiscountNotifier.DTOs;
using DiscountNotifier.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity;
using System.Data.Entity.Validation;

namespace DiscountNotifier.Controllers
{
    [RoutePrefix("api/Users")]
    public class UsersController : ApiController
    {
        private ApplicationDbContext db = new ApplicationDbContext();
        private ApplicationRoleManager _AppRoleManager = null;

        protected ApplicationRoleManager AppRoleManager
        {
            get
            {
                return _AppRoleManager ?? Request.GetOwinContext().GetUserManager<ApplicationRoleManager>();
            }
        }

        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? Request.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            set
            {
                _userManager = value;
            }
        }
        // GET: api/Users
        public IList<UserDTO> GetApplicationUsers()
        {
            string roleName = "User";
            var role = AppRoleManager.Roles.Single(r => r.Name == roleName);

            var users = db.Users
                .Where(u => u.Roles.Any(r => r.RoleId == role.Id))
                .Select(u => new UserDTO {
                                    Id = u.Id,
                                    RegionId = u.RegionId,
                                    Username = u.UserName,
                                    Name = u.Name
                                });
            return users.ToList();
        }

        [Route("GetStoreKeepers")]
        public IList<UserDTO> GetStoreKeepers()
        {
            string roleName = "StoreKeeper";
            var role = AppRoleManager.Roles.Single(r => r.Name == roleName);

            var users = db.Users
                .Where(u => u.Roles.Any(r => r.RoleId == role.Id))
                .Select(u => new UserDTO
                {
                    Id = u.Id,
                    RegionId = u.RegionId,
                    Username = u.UserName,
                    Name = u.Name
                });
            return users.ToList();
        }

        // GET: api/Users/5
        [ResponseType(typeof(ApplicationUser))]
        public IHttpActionResult GetApplicationUser(string id)
        {
            ApplicationUser applicationUser = db.Users.Find(id);
            if (applicationUser == null)
            {
                return NotFound();
            }

            return Ok(applicationUser);
        }

        // PUT: api/Users/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutApplicationUser(string id, ApplicationUser applicationUser)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != applicationUser.Id)
            {
                return BadRequest();
            }

            db.Entry(applicationUser).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ApplicationUserExists(id))
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

        // POST: api/Users
        [ResponseType(typeof(ApplicationUser))]
        public IHttpActionResult PostApplicationUser(ApplicationUser applicationUser)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Users.Add(applicationUser);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (ApplicationUserExists(applicationUser.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return Ok(new UserDTO
            {
                Id = applicationUser.Id,
                RegionId = applicationUser.RegionId,
                Name = applicationUser.Name,
                Username = applicationUser.UserName
            });
        }

        [Route("AddStoreKeeper")]
        [ResponseType(typeof(ApplicationUser))]
        public IHttpActionResult PostStoreKeeper(ApplicationUser applicationUser)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Users.Add(applicationUser);
            
            try
            {
                db.SaveChanges();
                UserManager.AddToRole(applicationUser.Id, "StoreKeeper");
                db.SaveChanges();

            }
            catch (DbUpdateException)
            {
                if (ApplicationUserExists(applicationUser.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }
            catch (DbEntityValidationException ex)
            {
                // Retrieve the error messages as a list of strings.
                var errorMessages = ex.EntityValidationErrors
                        .SelectMany(x => x.ValidationErrors)
                        .Select(x => x.ErrorMessage);

                // Join the list to a single string.
                var fullErrorMessage = string.Join("; ", errorMessages);

                // Combine the original exception message with the new one.
                var exceptionMessage = string.Concat(ex.Message, " The validation errors are: ", fullErrorMessage);

                // Throw a new DbEntityValidationException with the improved exception message.
                throw new DbEntityValidationException(exceptionMessage, ex.EntityValidationErrors);
            }

            return Ok(new UserDTO
            {
                Id = applicationUser.Id,
                RegionId = applicationUser.RegionId,
                Name = applicationUser.Name,
                Username = applicationUser.UserName
            });
        }

        // DELETE: api/Users/5
        [ResponseType(typeof(ApplicationUser))]
        public IHttpActionResult DeleteApplicationUser(string id)
        {
            ApplicationUser applicationUser = db.Users.Find(id);
            if (applicationUser == null)
            {
                return NotFound();
            }

            db.Users.Remove(applicationUser);
            db.SaveChanges();

            return Ok(applicationUser);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ApplicationUserExists(string id)
        {
            return db.Users.Count(e => e.Id == id) > 0;
        }
    }
}