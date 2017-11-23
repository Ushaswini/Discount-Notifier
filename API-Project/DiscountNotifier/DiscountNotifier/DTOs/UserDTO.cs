using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DiscountNotifier.DTOs
{
    public class UserDTO
    {
        public string Id { get; set; }
        public int RegionId { get; set; }
        public string Name { get; set; }
        public string Username { get; set; }
    }
}