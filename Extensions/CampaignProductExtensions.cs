using Dtm.Framework.Base.Models;
using Dtm.Framework.ClientSites.Web;
using System;
using System.Collections.Generic;
using System.Linq;

namespace FMLSHOP.Extensions
{
    public static class CampaignProductExtensions
    {

        /// <summary>
        /// Returns the product name following the order of precedence: ProductName > ShortName product property
        /// </summary>
        public static string GetProductName(this CampaignProductView campaignProduct)
        {
            return campaignProduct.ProductName ?? string.Empty;
        }

        /// <summary>
        /// Returns the product short name that represents the shorter alternative version of the product
        /// </summary>
        public static string GetProductShortName(this CampaignProductView campaignProduct)
        {
            return campaignProduct.PropertyIndexer["ShortName", GetProductTitle(campaignProduct)];
        }

        /// <summary>
        /// Returns the product title that represents the product detail page title
        /// </summary>
        /// <param name="campaignProduct"></param>
        /// <returns></returns>
        public static string GetProductTitle(this CampaignProductView campaignProduct)
        {
            return campaignProduct.Title ?? GetProductName(campaignProduct);
        }

        /// <summary>
        /// Determines if the current product is considered "Live" based on the "IsLive" product property. 
        /// If on dtmstage domain, this will always return true.
        /// </summary>
        public static bool IsProductLive(this CampaignProductView campaignProduct)
        {
            return DtmContext.IsStage || !DtmContext.IsStage && !string.Equals(campaignProduct.PropertyIndexer["IsLive"] ?? string.Empty, "false", StringComparison.InvariantCultureIgnoreCase);
        }

        /// <summary>
        /// Determines if the current product is considered "Out of Stock" based on the "IsOOS" product property
        /// </summary>
        public static bool IsProductOutOfStock(this CampaignProductView campaignProduct)
        {
            return campaignProduct.IsOutOfStock || string.Equals(campaignProduct.PropertyIndexer["IsOOS"] ?? string.Empty, "true", StringComparison.InvariantCultureIgnoreCase);
        }

        /// <summary>
        /// Determines if the current product is considered "New" based on the "IsNew" product property
        /// </summary>
        public static bool IsProductNew(this CampaignProductView  campaignProduct)
        {
            return string.Equals(campaignProduct.PropertyIndexer["IsNew"] ?? string.Empty, "true", StringComparison.InvariantCultureIgnoreCase);
        }

        /// <summary>
        /// Returns the variant name based on the product property "IsVariantOf"
        /// </summary>
        public static string GetVariantNameByProduct(this CampaignProductView campaignProduct)
        {
            return campaignProduct.PropertyIndexer["IsVariantOf", string.Empty];
        }

        /// <summary>
        /// Returns all variant products associated with a campaign product using the "IsVariantOf"
        /// (example: if the current PDP is the PLUS product; then this will get PLUS, PLUS4PK and PLUS12PK)
        /// </summary>
        public static List<CampaignProductView> GetVariantProductsByOwnerProduct(this CampaignProductView campaignProduct)
        {
            return DtmContext.CampaignProducts.Where(cp => 
                string.Equals(
                    cp.PropertyIndexer["IsVariantOf"], 
                    campaignProduct.ProductCode, 
                    StringComparison.InvariantCultureIgnoreCase)
                ).ToList() ?? new List<CampaignProductView>();
        }

        /// <summary>
        /// Returns the owner product associated with a variant campaign product 
        /// (example: if the current PDP is the PLUS4PK proudct; then this will get the PLUS product
        /// </summary>
        public static CampaignProductView GetOwnerProductByVariantProduct(this CampaignProductView campaignProduct)
        {
            return DtmContext.CampaignProducts.FirstOrDefault(cp =>
                string.Equals(
                    cp.ProductCode,
                    campaignProduct.PropertyIndexer["IsVariantOf"],
                    StringComparison.InvariantCultureIgnoreCase
                )
            );
        }

        /// <summary>
        /// Returns the label name associated with the product variant radio input
        /// </summary>
        public static string GetInputLabel(this CampaignProductView campaignProduct)
        {
            return campaignProduct.PropertyIndexer["InputLabel", string.Empty];
        }

        /// <summary>
        /// Writes out the appropriate HTML string to represent the product's price based on circumstances
        /// </summary>
        /// <param name="campaignProduct"></param>
        /// <returns></returns>
        public static string FormatPriceHTML(this CampaignProductView campaignProduct)
        {
            string priceOverride = campaignProduct.PropertyIndexer["PriceOverride", string.Empty];
            string priceText = !string.IsNullOrWhiteSpace(priceOverride) ? priceOverride : string.Format("{0}", campaignProduct.Price.ToString("C2"));

            string strikethroughPrice = campaignProduct.PropertyIndexer["StrikethroughPrice", string.Empty];

            if (!string.IsNullOrEmpty(strikethroughPrice))
            {
                decimal originalPrice = campaignProduct.Price;
                decimal discountPrice = campaignProduct.Price;

                decimal.TryParse(strikethroughPrice, out originalPrice);

                if (originalPrice != 0)
                {
                    decimal discountRate = (originalPrice - discountPrice) / originalPrice;

                    string discountRatePercent = discountRate.ToString("P0");

                    priceText = string.Format("<s>{0}</s> <b>{1}</b> ({2} off)", originalPrice.ToString("C2"), discountPrice.ToString("C2"), discountRatePercent);
                }
            }

            return priceText;
        }

        /// <summary>
        /// Returns a list of <c>CampaignProductView</c> entries that assign the <c>campaignProduct</c> product code to the "IsOfferedBy" property
        /// </summary>
        /// <param name="campaignProduct"></param>
        /// <returns></returns>
        public static List<CampaignProductView> GetRelatedProductsByProductView(this CampaignProductView campaignProduct)
        {
            return DtmContext.CampaignProducts.Where(cp => string.Equals(cp.PropertyIndexer["IsOfferedBy"], campaignProduct.ProductCode)).ToList();
        }

        /// <summary>
        /// Returns all variant products associated with a campaign product using the "IsVariantOf"
        /// (example: if the current PDP is the PLUS product; then this will get PLUS, PLUS4PK and PLUS12PK)
        /// </summary>
        public static List<CampaignProductView> GetVariantProducts(this CampaignProductView campaignProduct)
        {
            return DtmContext.CampaignProducts.Where(cp =>
                string.Equals(
                    cp.PropertyIndexer["IsVariantOf"],
                    campaignProduct.ProductCode,
                    StringComparison.InvariantCultureIgnoreCase
                )
            ).ToList();
        }

        /// <summary>
        /// Returns a list of products that are considered "Live" based on the "IsLive" product property. 
        /// If on dtmstage domain, this will always return the list that was provided.
        /// </summary>
        public static List<CampaignProductView> FilterProductsByLiveProperty(this List<CampaignProductView> campaignProducts)
        {
            return campaignProducts.Where(cp => cp.IsProductLive()).ToList();
        }

        /// <summary>
        /// Attempts to format the BazaarVoice inline-ratings HTML snippet placeholder based on the "BazaarVocieId" property; otherwise, an empty string is returned.
        /// </summary>
        /// <param name="campaignProduct"></param>
        /// <returns></returns>
        public static string FormatBazaarVoiceInlineRatings(this CampaignProductView campaignProduct)
        {
            string bazaarVoiceId = campaignProduct.PropertyIndexer["BazaarVoiceId"];

            return !string.IsNullOrEmpty(bazaarVoiceId) 
                ? string.Format(@"<div data-bv-show=""inline_rating"" data-bv-product-id=""{0}""></div>", bazaarVoiceId) 
                : string.Empty;
        }

        /// <summary>
        /// Attempts to format the BazaarVoice review HTML snippet placeholder based on the "BazaarVoiceId" property; otherwise, an empty string is returned.
        /// </summary>
        /// <param name="campaignProduct"></param>
        /// <returns></returns>
        public static string FormatBazaarVoiceReviews(this CampaignProductView campaignProduct)
        {
            string bazaarVoiceId = campaignProduct.PropertyIndexer["BazaarVoiceId"];

            return !string.IsNullOrEmpty(bazaarVoiceId) 
                ? string.Format(@"<div data-bv-show=""reviews"" data-bv-product-id=""{0}""></div>", bazaarVoiceId) 
                : string.Empty;
        }
    }
}