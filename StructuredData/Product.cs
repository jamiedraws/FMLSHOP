using System.Collections.Generic;

namespace FMLSHOP.StructuredData
{
    /// <summary>
    /// Any offered product or service. For example: a pair of shoes; a concert ticket; the rental of a car; a haircut; or an episode of a TV show streamed online.
    /// https://schema.org/Product
    /// </summary>
    public class Product
    {
        /// <summary>
        /// The product page URL.
        /// </summary>
        public string Id { get; set; }
        /// <summary>
        /// The name of the item.
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// An image of the item. This can be a URL or a fully described ImageObject.
        /// </summary>
        public string Image { get; set; }
        /// <summary>
        /// A description of the item.
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// The Stock Keeping Unit (SKU), i.e. a merchant-specific identifier for a product or service, or the product to which the offer refers.
        /// </summary>
        public string Sku { get; set; }
        /// <summary>
        /// The brand(s) associated with a product or service, or the brand(s) maintained by an organization or business person.
        /// </summary>
        public string Brand { get; set; }
        /// <summary>
        /// An offer to provide this item—for example, an offer to sell a product, rent the DVD of a movie, perform a service, or give away tickets to an event. Use businessFunction to indicate the kind of transaction offered, i.e. sell, lease, etc. This property can also be used to describe a Demand. While this property is listed as expected on a number of common types, it can be used in others. In that case, using a second type, such as Product or a subtype of Product, can clarify the nature of the offer.
        ///Inverse property: itemOffered
        /// </summary>
        public List<Offer> Offers { get; set; }
        /// <summary>
        /// An associated logo.
        /// </summary>
        public string Logo { get; set; }

        /// <summary>
        /// A review of the item. Supersedes reviews.
        /// </summary>
        public List<Review> Review { get; set; }

        public Product()
        {
            Id = string.Empty;
            Name = string.Empty;
            Image = string.Empty;
            Description = string.Empty;
            Sku = string.Empty;
            Brand = string.Empty;
            Logo = string.Empty;
            Offers = new List<Offer>();
            Review = new List<Review>();
        }
    }
}