using Dtm.Framework.Base.Models;

namespace FMLSHOP.CategoryRouter
{
    /// <summary>
    /// Object containing a campaign product, the campaign category that the product belongs to along with url routes to the product category page, product listing page and product detail page.
    /// </summary>
    public class CategoryProductRouter
    {
        /// <summary>
        /// Represents the campaign category that contains the campaign product
        /// </summary>
        public CategoryView CampaignCategory { get; set; }
        /// <summary>
        /// Represents a campaign product view
        /// </summary>
        public CampaignProductView CampaignProduct { get; set; }
        /// <summary>
        /// Represents a relative url route to the product category page. Example: "/products"
        /// </summary>
        public string RouteToProductCategoryPage { get; set; }
        /// <summary>
        /// Represents a relative url route to the product detail page. Example: "/products/mouthwash/aktivoxigen-serum"
        /// </summary>
        public string RouteToProductDetailPage { get; set; }
        /// <summary>
        /// Represents a relative url route to the product listing page. Example: "/products/mouthwash"
        /// </summary>
        public string RouteToProductListingPage { get; set; }
    }
}