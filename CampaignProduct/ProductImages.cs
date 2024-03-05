using FMLSHOP.Utils;

namespace FMLSHOP.CampaignProduct
{
    public class ProductImages : ImageEngine
    {
        public ProductImages(string productCode, string imagePath = null) : base(productCode, imagePath ?? "images/products/" + productCode)
        {

        }
    }
}