using System;

namespace FMLSHOP.LimitedTimeOffer
{
    public class FathersDayOffer : LimitedTimeOffer
    {
        /// <summary>
        /// Represents the fathers day 2023 limited time offer.
        /// https://pm.digitaltargetmarketing.com/index.php?m=tasks&a=view&task_id=114118
        /// </summary>
        public FathersDayOffer() : base("FATHERSDAY2023", DateTime.Parse("6/10/2023 12:00 AM"), DateTime.Parse("6/17/2023 11:59 PM"))
        {

        }
    }
}