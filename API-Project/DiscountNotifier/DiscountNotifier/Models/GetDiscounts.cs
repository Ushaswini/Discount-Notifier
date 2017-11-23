using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DiscountNotifier.Models
{
    public class Discounts
    {
        public List<Discount> seedDiscounts()
        {
            List<Discount> discounts = new List<Discount>();

            //Region 1 - Produce
            discounts.Add(new Discount { Id = 1, RegionId = 1, OfferText = "Pineapple", Price = "1.18", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/pineapple.png" });
            discounts.Add(new Discount { Id = 2, RegionId = 1, OfferText = "Oranges", Price = "0.89", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/oranges.png" });
            discounts.Add(new Discount { Id = 3, RegionId = 1, OfferText = "Fresh express letuce", Price = "3.69", DiscountPercent = 15, ImageUrl = "https://discountsapi.blob.core.windows.net/images/lettuce.jpg" });
            discounts.Add(new Discount { Id = 4, RegionId = 1, OfferText = "Spinach", Price = "1.23", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/spinach.png" });
            discounts.Add(new Discount { Id = 5, RegionId = 1, OfferText = "Nectarines", Price = "3.67", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/fresh-nectarines.png" });
            discounts.Add(new Discount { Id = 6, RegionId = 1, OfferText = "Fresh seedless whole watermelon", Price = "6.99", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/watermellon.jpg" });


            //Region2 - Grocery
            discounts.Add(new Discount { Id = 7, RegionId = 2, OfferText = "Croissants", Price = "2.79", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/croissants.png" });
            discounts.Add(new Discount { Id = 8, RegionId = 2, OfferText = "Brach's Jelly beans", Price = "2.21", DiscountPercent = 20, ImageUrl = "https://discountsapi.blob.core.windows.net/images/jelly-beans.png" });
            discounts.Add(new Discount { Id = 9, RegionId = 2, OfferText = "Cococola", Price = "6.99", DiscountPercent = 15, ImageUrl = "https://discountsapi.blob.core.windows.net/images/coca-cola.png" });
            discounts.Add(new Discount { Id = 10, RegionId = 2, OfferText = "Gastorade", Price = "3.89", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/gatorade.png" });
            discounts.Add(new Discount { Id = 11, RegionId = 2, OfferText = "Cranberry cocktail", Price = "1.89", DiscountPercent = 15, ImageUrl = "https://discountsapi.blob.core.windows.net/images/cranberry-cocktail.png" });
            discounts.Add(new Discount { Id = 12, RegionId = 2, OfferText = "Milk", Price = "10.5", DiscountPercent = 20, ImageUrl = "https://discountsapi.blob.core.windows.net/images/milk.jpg" });
            discounts.Add(new Discount { Id = 13, RegionId = 2, OfferText = "Hi-c Fruit punch", Price = "4.67", DiscountPercent = 15, ImageUrl = "https://discountsapi.blob.core.windows.net/images/hi-c-fruit-punch.png" });


            //Region-3 Lifestyle
            discounts.Add(new Discount { Id = 14, RegionId = 3, OfferText = "Dial soap", Price = "2.99", DiscountPercent = 20, ImageUrl = "https://discountsapi.blob.core.windows.net/images/dial_soap.jpg" });
            discounts.Add(new Discount { Id = 15, RegionId = 3, OfferText = "Scotch Bite sponges", Price = "5.89", DiscountPercent = 15, ImageUrl = "https://discountsapi.blob.core.windows.net/images/scotch-brite-sponges.png" });
            discounts.Add(new Discount { Id = 16, RegionId = 3, OfferText = "Organix Conditioner", Price = "13.46", DiscountPercent = 10, ImageUrl = "https://discountsapi.blob.core.windows.net/images/organix-conditioner.png" });
            discounts.Add(new Discount { Id = 17, RegionId = 3, OfferText = "US Weekly", Price = "4.99", DiscountPercent = 15, ImageUrl = "https://discountsapi.blob.core.windows.net/images/us-weekly.png" });

            return discounts;
        }
    }
}