using Dtm.Framework.Base.Models;
using Dtm.Framework.ClientSites.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using FMLSHOP.Extensions;

namespace FMLSHOP.CategoryRouter
{
    /// <summary>
    /// Interfaces with both <c>CampaignProductView</c> and <c>CategoryView</c> and models around the <c>CategoryProductRoute</c> object. 
    /// This enables each campaign product to access routing urls mapping to the product category page, product listing page and product detail page.
    /// </summary>
    public class CategoryProductRouterEngine
    {
        public readonly List<CategoryView> ProductCategories;

        /// <summary>
        /// Represents a list of all available category codes
        /// </summary>
        private readonly List<string> _categoryCodes;

        /// <summary>
        /// Represents the campaign offer version id as a URL query string parameter
        /// </summary>
        private readonly string _versionContextQueryParameter;
        
        public CategoryProductRouterEngine()
        {
            ProductCategories = DtmContext.CampaignCategories.ToList();

            _categoryCodes = ProductCategories.Select(cc => cc.Code).ToList();

            _versionContextQueryParameter = string.Format("?cver={0}", DtmContext.VersionId);
        }

        /// <summary>
        /// Takes a <c>CampaignProductView</c> and returns a new <c>CategoryProductRoute</c> object. 
        /// Enables access to the products associated category along with the appropriate routing to the product category page and product listing page.
        /// </summary>
        public CategoryProductRouter GetCategoryProductByCampaignProductView(CampaignProductView campaignProduct)
        {
            if (campaignProduct == null || string.IsNullOrEmpty(campaignProduct.ProductCode))
            {
                return new CategoryProductRouter();
            }

            string categoryCode  = _categoryCodes.FirstOrDefault(cc => campaignProduct.CategoryIndexer.Has(cc));

            if (categoryCode == null)
            {
                return new CategoryProductRouter();
            }

            CategoryView campaignCategory = ProductCategories.FirstOrDefault(cc => cc.Code == categoryCode);

            string route = GetParentCategoryByChildCategory(campaignCategory).RedirectUrl;
            string categoryRoute = CreateRouteToProductCategoryPage(route);
            string listingRoute = CreateRouteToProductListingPage(categoryRoute, campaignCategory);

            return new CategoryProductRouter
            {
                CampaignCategory = campaignCategory,
                CampaignProduct = campaignProduct,
                RouteToProductCategoryPage = categoryRoute,
                RouteToProductListingPage = listingRoute,
                RouteToProductDetailPage = CreateRouteToProductDetailPage(listingRoute, campaignProduct)
            };
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a product code and returns a new <c>CategoryProductRouter</c> object
        /// </summary>
        /// <param name="productCode"></param>
        /// <returns></returns>
        public CategoryProductRouter GetCategoryProductByProductCode(string productCode)
        {
            CampaignProductView campaignProduct = DtmContext.CampaignProducts.FirstOrDefault(cp => cp.ProductCode == productCode) ?? new CampaignProductView();

            return GetCategoryProductByCampaignProductView(campaignProduct);
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a product slug and returns a new <c>CategoryProductRouter</c> object
        /// </summary>
        /// <param name="productSlug"></param>
        /// <returns></returns>
        public CategoryProductRouter GetCategoryProductByProductSlug(string productSlug)
        {
            CampaignProductView campaignProduct = DtmContext.CampaignProducts.FirstOrDefault(cp => string.Equals(cp.PropertyIndexer["UrlSlug"], productSlug, StringComparison.InvariantCultureIgnoreCase));

            return GetCategoryProductByCampaignProductView(campaignProduct);
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a category slug and returns a new list of <c>CategoryProductRoute</c> objects.
        /// Each entry enables access to the products associated category along with the appropriate routing to the product category page and product listing page.
        /// </summary>
        public List<CategoryProductRouter> GetProductsByCategorySlug(string categorySlug)
        {
            CategoryView campaignCategory = ProductCategories.FirstOrDefault(cc => cc.RedirectUrl == categorySlug);

            return GetProductsByCategoryView(campaignCategory);
        }

        /// <summary>
        /// Takes a <c>CategoryView</c> and returns a new list of <c>CategoryProductRoute</c> objects.
        /// Each entry enables access to the products associated category along with the appropriate routing to the product category page and product listing page.
        /// </summary>
        public List<CategoryProductRouter> GetProductsByCategoryView(CategoryView campaignCategory)
        {
            string route = GetParentCategoryByChildCategory(campaignCategory).RedirectUrl;
            string categoryRoute = CreateRouteToProductCategoryPage(route);
            string listingRoute = CreateRouteToProductListingPage(categoryRoute, campaignCategory);

            return DtmContext.CampaignProducts
                .Where(cp => cp.CategoryIndexer.Has(campaignCategory.Code))
                .Select(cp => new CategoryProductRouter
                {
                    CampaignCategory = campaignCategory,
                    CampaignProduct = cp,
                    RouteToProductCategoryPage = categoryRoute,
                    RouteToProductListingPage = categoryRoute,
                    RouteToProductDetailPage = CreateRouteToProductDetailPage(listingRoute, cp)
                })
                .OrderBy(cp => cp.CampaignProduct.CategoryIndexer[campaignCategory.Code])
                .ToList();
        }

        /// <summary>
        /// Takes a list of <c>CategoryProductRouter</c> objects and determines if each object contains all of the requirements to operate
        /// </summary>
        /// <param name="categoryProducts"></param>
        /// <returns></returns>
        public List<CategoryProductRouter> GetValidCategoryProductRouterCollection(List<CategoryProductRouter> categoryProducts)
        {
            return categoryProducts.Where(cp => IsValidCategoryProductRouter(cp)).ToList();
        }

        /// <summary>
        /// Returns a new list of <c>CategoryView</c> objects that are identified as "MainNavigation" and don't have the same "Id" as the current parent category
        /// </summary>
        public List<CategoryView> GetAlternateParentCategories(CategoryView parentCategory)
        {
            return ProductCategories.Where(cc => cc.CategoryTypeId == 2 && cc.Id != parentCategory.Id).OrderBy(cc => cc.DisplayOrder).ToList();
        }

        /// <summary>
        /// Takes a <c>CategoryView</c> that represents a child category and attempts to return it's parent category
        /// </summary>
        public CategoryView GetParentCategoryByChildCategory(CategoryView childCategory, string parentCategoryCode = "")
        {
            if (string.IsNullOrWhiteSpace(parentCategoryCode))
            {
                return ProductCategories.FirstOrDefault(cc => cc.Id == childCategory.ParentCategoryId) ?? new CategoryView();
            }

            return ProductCategories.FirstOrDefault(cc => cc.Id == childCategory.ParentCategoryId && cc.Code == parentCategoryCode) ?? new CategoryView();
        }

        /// <summary>
        /// Takes a <c>CategoryView</c> that represents a parent category and attempts to return a list of all the children categories
        /// </summary>
        public List<CategoryView> GetChildCategoriesByParentCategory(CategoryView parentCategory)
        {
            return ProductCategories.Where(cc => cc.ParentCategoryId == parentCategory.Id && DtmContext.CampaignProducts.Any(cp=> cp.CategoryIndexer.Has(cc.Code))).OrderBy(cc => cc.DisplayOrder).ToList() ?? new List<CategoryView>();
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a parent category code and attempts to return a list of all the children categories
        /// </summary>
        public List<CategoryView> GetChildCategoriesByParentCategoryCode(string categoryCode)
        {
            CategoryView parentCampaignCategory = ProductCategories.FirstOrDefault(cc => string.Equals(cc.Code, categoryCode, StringComparison.InvariantCultureIgnoreCase)) ?? new CategoryView();

            return GetChildCategoriesByParentCategory(parentCampaignCategory);
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a campaign category and attempts to return it's <c>CategoryView</c> object
        /// </summary>
        public CategoryView GetCampaignCategoryByCategoryCode(string categoryCode)
        {
            return ProductCategories.FirstOrDefault(cc => string.Equals(cc.Code, categoryCode, StringComparison.InvariantCultureIgnoreCase)) ?? new CategoryView();
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a parent category route and returns a relative route url (example: "/products" or "/solutions")
        /// </summary>
        public string CreateRouteToProductCategoryPage(string categoryRoute)
        {
            return string.Format("/{0}{1}", categoryRoute, _versionContextQueryParameter).ToLower();
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a parent category route along with a <c>CategoryView</c> that represents a child category and returns a relative route url (example: "/products/mouthwash" or "/solutions/tonsil-stones")
        /// </summary>
        public string CreateRouteToProductListingPage(string categoryRoute, CategoryView campaignCategory)
        {
            return string.Format("{0}/{1}{2}", categoryRoute.Replace(_versionContextQueryParameter, string.Empty), campaignCategory.RedirectUrl, _versionContextQueryParameter).ToLower();
        }

        /// <summary>
        /// Takes a <c>string</c> that represents a product listing route along with a <c>CampaignProductView</c> that represents the individual product and returns a relative route url (example: "/products/mouthwash/aktivoxigen-serum" or "/solutions/tonsil-stones/tonsil-stones-deluxe-kit")
        /// </summary>
        public string CreateRouteToProductDetailPage(string listingRoute, CampaignProductView campaignProduct)
        {
            return string.Format("{0}/{1}{2}", listingRoute.Replace(_versionContextQueryParameter, string.Empty), campaignProduct.PropertyIndexer["UrlSlug", string.Empty], _versionContextQueryParameter).ToLower();
        }

        /// <summary>
        /// Takes a <c>categoryCode</c>, that represents a campaign category by the code name and pulls for the string route to the product category page.
        /// </summary>
        /// <param name="categoryCode"></param>
        /// <returns></returns>
        public string GetRouteToProductCategoryPageByCategoryCode(string categoryCode)
        {
            CategoryView campaignCategory = ProductCategories.FirstOrDefault(cc => string.Equals(cc.Code, categoryCode, StringComparison.InvariantCultureIgnoreCase) && cc.ParentCategoryId == null);

            if (campaignCategory == null)
            {
                return string.Empty;
            }

            if (string.IsNullOrWhiteSpace(campaignCategory.RedirectUrl))
            {
                return string.Empty;
            }

            return CreateRouteToProductCategoryPage(campaignCategory.RedirectUrl);
        }

        /// <summary>
        /// Takes a <c>categoryCode</c>, that represents a campaign category by the code name and pulls for the string route to the product listing page.
        /// </summary>
        /// <param name="categoryCode"></param>
        /// <returns></returns>
        public string GetRouteToProductListingPageByCategoryCode(string categoryCode, string parentCategoryCode = "")
        {
            CategoryView campaignCategory = GetCampaignCategoryByCategoryCode(categoryCode);
            CategoryView parentCategory = GetParentCategoryByChildCategory(campaignCategory, parentCategoryCode);

            if (parentCategory == null || campaignCategory == null)
            {
                return string.Empty;
            }

            if (string.IsNullOrWhiteSpace(parentCategory.RedirectUrl))
            {
                return string.Empty;
            }

            string categoryRoute = GetRouteToProductCategoryPageByCategoryCode(parentCategory.Code);

            return CreateRouteToProductListingPage(categoryRoute, campaignCategory);
        }

        /// <summary>
        /// Takes a <c>categoryProduct</c>, that represents a CategoryProductRouter object and determines whether the object is considered valid based on the values it contains
        /// </summary>
        /// <param name="categoryProduct"></param>
        /// <returns></returns>
        public bool IsValidCategoryProductRouter(CategoryProductRouter categoryProduct)
        {
            return !string.IsNullOrWhiteSpace(categoryProduct.RouteToProductDetailPage) 
                && !string.IsNullOrWhiteSpace(categoryProduct.RouteToProductListingPage) 
                && !string.IsNullOrWhiteSpace(categoryProduct.RouteToProductCategoryPage)
                && categoryProduct.CampaignProduct != null
                && categoryProduct.CampaignProduct.PropertyIndexer.Has("UrlSlug")
                && categoryProduct.CampaignCategory != null;
        }

        /// <summary>
        /// Takes a <c>campaignCategory</c> and returns a list of CategoryProductRouter objects where each entry's campaign product is the owner product and whether that product is marked as "IsLive"
        /// </summary>
        /// <param name="campaignCategory"></param>
        /// <returns></returns>
        public List<CategoryProductRouter> FilterCategoryProductsByCampaignCategory(CategoryView campaignCategory)
        {
            List<CategoryProductRouter> categoryProducts = GetProductsByCategoryView(campaignCategory);

            return GetValidCategoryProductRouterCollection(categoryProducts)
                .Where(cp => cp.CampaignProduct.IsProductLive())
                .ToList();
        }
    }
}