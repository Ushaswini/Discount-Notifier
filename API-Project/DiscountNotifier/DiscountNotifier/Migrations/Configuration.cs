namespace DiscountNotifier.Migrations
{
    using DiscountNotifier.Models;
    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<DiscountNotifier.Models.ApplicationDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(DiscountNotifier.Models.ApplicationDbContext context)
        {
            ApplicationUserManager manager = new ApplicationUserManager(new UserStore<ApplicationUser>(context));
            var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));

            if (roleManager.Roles.Count() == 0)
            {
                roleManager.Create(new IdentityRole { Name = "StoreKeeper" });
                roleManager.Create(new IdentityRole { Name = "Admin" });
                roleManager.Create(new IdentityRole { Name = "User" });
            }

            var regionAdmin = new Region
            {
                RegionId = 4,
                RegionName = "Admin",
                BeaconId = "1",
                StoreKeeperName = "Admin"

            };
            var produceRegion = new Region
            {
                RegionId = 1,
                RegionName = "Produce",
                BeaconId = "B9407F30-F5F8-466E-AFF9-25556B57FE6D",
                StoreKeeperName = "Store Keeper - Produce"
            };
            var lifestyleRegion = new Region
            {
                RegionId = 3,
                RegionName = "Lifestyle",
                BeaconId = "B9407F30-F5F8-466E-AFF9-25556B57FE6D",
                StoreKeeperName = "Store Keeper - LifeStyle"
            };
            var groceryRegion = new Region
            {
                RegionId = 2,
                RegionName = "Grocery",
                BeaconId = "B9407F30-F5F8-466E-AFF9-25556B57FE6D",
                StoreKeeperName = "Store Keeper - Grocery"
            };
            context.Regions.AddOrUpdate(produceRegion, lifestyleRegion, groceryRegion, regionAdmin);

            

            var storeKeeper1 = new ApplicationUser
            {
                Email = "storekeeper1@gmail.com",
                UserName = "StoreKeep1",
                Name = "Store Keeper - Produce",
                RegionId = 1
            };

            var storeKeeper2 = new ApplicationUser
            {
                Email = "storeKeeper2@gmail.com",
                UserName = "StoreKeep2",
                Name = "Store Keeper - Grocery",
                RegionId = 2
            };

            var storeKeeper3 = new ApplicationUser
            {
                Email = "storeKeeper3@gmail.com",
                UserName = "StoreKeep3",
                Name = "Store Keeper - Lifestyle",
                RegionId = 3
            };

            manager.Create(storeKeeper1, "StoreKeeper1@SSDI");
            var store1 = manager.FindByName("StoreKeep1");
            manager.AddToRole(store1.Id, "StoreKeeper");

            manager.Create(storeKeeper2, "StoreKeeper2@SSDI");
            var store2 = manager.FindByName("StoreKeep2");
            manager.AddToRole(store2.Id, "StoreKeeper");

            manager.Create(storeKeeper3, "StoreKeeper3@SSDI");
            var store3 = manager.FindByName("StoreKeep3");
            manager.AddToRole(store3.Id, "StoreKeeper");

            var discounts = (new Discounts()).seedDiscounts();

            foreach(var d in discounts)
            {
                context.Discounts.AddOrUpdate(d);
            }

            var admin = new ApplicationUser
            {
                Email = "admin@gmail.com",
                UserName = "Admin",
                RegionId = 4
                // StudyGroupId = 1 + ""
            };

            manager.Create(admin, "Admin@6010");

            var adminUser = manager.FindByName("Admin");
            manager.AddToRoles(adminUser.Id, "Admin");

            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //
            //    context.People.AddOrUpdate(
            //      p => p.FullName,
            //      new Person { FullName = "Andrew Peters" },
            //      new Person { FullName = "Brice Lambson" },
            //      new Person { FullName = "Rowan Miller" }
            //    );
            //
        }
    }
}
