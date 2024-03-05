using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FMLSHOP.Classes
{
    public class HouseholdOrderResponse
    {
        public bool IsSuccess { get; set; }

        public int EmailCount { get; set; }

        public string Message { get; set; }
    }
}