using Dtm.Framework.ClientSites.Web;
using System;
using System.Web;

namespace FMLSHOP.LimitedTimeOffer
{
    public class LimitedTimeOffer
    {
        /// <summary>
        /// Represents the exact time and date the limited time offer begins
        /// </summary>
        private DateTime StartDateTime { get; set; }

        /// <summary>
        /// Represents the exact time and date the limited time offer ends
        /// </summary>
        private DateTime EndDateTime { get; set; }

        /// <summary>
        /// Represents the current time and date in Pacific Standard Time
        /// </summary>
        private DateTime CurrentDateTime { get; set; }

        /// <summary>
        /// Value for the testLimitedTimeOfferId URL query parameter
        /// </summary>
        private readonly string StageTestParameter = HttpContext.Current.Request["testLimitedTimeOfferId"] ?? string.Empty;

        /// <summary>
        /// Identifier of the limited time offer instance
        /// </summary>
        public string Id { get; set; }

        /// <summary>
        /// Defines a date-range that represents a limited time offer in Pacific Standard Time. 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="startDateTime"></param>
        /// <param name="endDateTime"></param>
        public LimitedTimeOffer(string id, DateTime startDateTime, DateTime endDateTime)
        {
            this.Id = id;
            this.StartDateTime = startDateTime;
            this.EndDateTime = endDateTime;

            TimeZoneInfo timezone = TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time");

            this.CurrentDateTime = TimeZoneInfo.ConvertTime(DateTime.Now, timezone);
        }

        /// <summary>
        /// Determines if the limited time offer is currently active according to the date range or whether a stage test is performed.
        /// </summary>
        public bool IsActive
        { 
            get
            {
                return (this.CurrentDateTime >= this.StartDateTime && this.CurrentDateTime <= this.EndDateTime) || DtmContext.IsStage && this.StageTestParameter.Equals(this.Id);
            }
        }
    }
}