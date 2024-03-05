using FMLSHOP.Utils;

namespace FMLSHOP.CategoryRouter
{
    public class CategoryImages : ImageEngine
    {
        public CategoryImages(string categoryCode, string imagePath = null) : base(categoryCode, imagePath ?? "images/categories/" + categoryCode)
        {

        }
    }
}