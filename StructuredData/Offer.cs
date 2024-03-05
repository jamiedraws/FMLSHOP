using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FMLSHOP.StructuredData
{
    /// <summary>
    /// An offer to transfer some rights to an item or to provide a service — for example, an offer to sell tickets to an event, to rent the DVD of a movie, to stream a TV show over the internet, to repair a motorcycle, or to loan a book.
    /// https://schema.org/Offer
    /// </summary>
    public class Offer
    {
        /// <summary>
        /// URL of the item.
        /// </summary>
        public string Url { get; set; }
        /// <summary>
        /// The currency of the price, or a price component when attached to PriceSpecification and its subtypes.
        ///Use standard formats: ISO 4217 currency format, e.g. "USD"; Ticker symbol for cryptocurrencies, e.g. "BTC"; well known names
        ///for Local Exchange Trading Systems(LETS) and other currency types, e.g. "Ithaca HOUR".
        /// </summary>
        public string PriceCurrency { get; set; }
        /// <summary>
        /// The offer price of a product, or of a price component when attached to PriceSpecification and its subtypes.
        /// </summary>
        public string Price { get; set; }
        /// <summary>
        /// The availability of this item—for example In stock, Out of stock, Pre-order, etc.
        /// </summary>
        public string Avaiability { get; set; }
        /// <summary>
        /// The Stock Keeping Unit (SKU), i.e. a merchant-specific identifier for a product or service, or the product to which the offer refers.
        /// </summary>
        public string Sku { get; set; }
        /// <summary>
        /// A description of the item.
        /// </summary>
        public string Description { get; set; }

        public Offer()
        {
            Url = string.Empty;
            PriceCurrency = string.Empty;
            Price = string.Empty;
            Avaiability = string.Empty;
            Sku = string.Empty;
            Description = string.Empty;
        }
    }
}