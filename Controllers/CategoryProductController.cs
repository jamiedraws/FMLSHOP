using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Dtm.Framework.Base.Extensions;
using Dtm.Framework.Base.Models;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.ClientSites.Web.Controllers;
using Dtm.Framework.Models.Ecommerce;
using Dtm.Framework.Models.Ecommerce.Repositories;
using FMLSHOP.CategoryRouter;
using FMLSHOP.Extensions;
using FMLSHOP.Navigation;
using Dtm.Framework.Base.Caches.Models;

namespace FMLSHOP.Controllers
{
    public class CategoryProductController : OrderPageController
    {
        private readonly Paginate _paginate;

        public CategoryProductController()
        {
            _paginate = new Paginate(1000);
        }

        /// <summary>
        /// Instance of the <c>CategoryProductRouterEngine</c> object that will handle creating routing strings to a product category page, product listing page and product detail page.
        /// </summary>
        private CategoryProductRouterEngine categoryProductRouterEngine = new CategoryProductRouterEngine();

        /// <summary>
        /// Handles the route to a product detail page based on a campaign product's "productSlug" product property along with a campaign category's "RedirectUrl" name. 
        /// This is capable of redirecting back to a product listing page given a valid campaign category name and invalid campaign product productSlug and redirecting back to a product category page given an invalid campaign category name.
        /// </summary>
        /// <param name="parentCategory"></param>
        /// <param name="category"></param>
        /// <param name="productSlug"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        public ActionResult ProductDetailPage(string parentCategory, string category, string productSlug)
        {
            SetOfferVersion();
            InitVisitorSession();

            CategoryView campaignCategory = GetCampaignCategoryByParentCategoryName(category, parentCategory);

            if (campaignCategory.RedirectUrl != category)
            {
                return RenderCategoriesByParentCategory(parentCategory);
            }

            CampaignProductView currentProduct = DtmContext.CampaignProducts
                .FirstOrDefault(
                    cp => string.Equals(cp.PropertyIndexer["UrlSlug"], productSlug, StringComparison.InvariantCultureIgnoreCase)
                    && cp.CategoryIndexer.Has(campaignCategory.Code)
                );

            if (currentProduct == null)
            {
                ViewData["CurrentProductNotFound"] = true;

                return RenderProductsByCampaignCategory(campaignCategory);
            }

            if (!currentProduct.IsProductLive())
            {
                ViewData["CurrentProductNotFound"] = true;

                return RenderProductsByCampaignCategory(campaignCategory);
            }

            string productCategoryRoute = categoryProductRouterEngine.CreateRouteToProductCategoryPage(parentCategory);
            string productListingRoute = categoryProductRouterEngine.CreateRouteToProductListingPage(productCategoryRoute, campaignCategory);

            ViewData["ProductCategoryName"] = parentCategory;
            ViewData["ProductCategoryRoute"] = productCategoryRoute;
            ViewData["ProductListingRoute"] = productListingRoute;
            ViewData["ProductDetailRoute"] = categoryProductRouterEngine.CreateRouteToProductDetailPage(productListingRoute, currentProduct);

            ViewData["Category"] = campaignCategory;
            ViewData["CategoryProduct"] = categoryProductRouterEngine.GetCategoryProductByCampaignProductView(currentProduct);
            ViewData["CategoryProductRouterEngine"] = categoryProductRouterEngine;

            string view = currentProduct.ProductCode;

            if (ViewEngines.Engines.FindPartialView(this.ControllerContext, view).View == null)
            {
                view = "ProductDetailPage";
            }

            SetContextByPageCode("ProductDetailPage");

            return View(view, Model);
        }

        /// <summary>
        /// Handles the route to a product listing page based on a campaign category's "RedirectUrl" name. 
        /// This is capable of redirecting back to a product category page given an invalid campaign category name.
        /// </summary>
        /// <param name="category"></param>
        /// <param name="parentCategory"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        public ActionResult ProductListingPage(string category, string parentCategory)
        {
            SetOfferVersion();
            InitVisitorSession();

            CategoryView campaignCategory = GetCampaignCategoryByParentCategoryName(category, parentCategory);

            if (campaignCategory.RedirectUrl != category)
            {
                ViewData["CurrentCategoryNotFound"] = true;

                return RenderCategoriesByParentCategory(parentCategory);
            }

            return RenderProductsByCampaignCategory(campaignCategory);
        }

        /// <summary>
        /// Handles the route to a product category page based on a campaign category's "RedirectUrl" name.
        /// </summary>
        /// <param name="parentCategory"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        public ActionResult ProductCategoryPage(string parentCategory, string offer)
        {
            SetOfferVersion();
            InitVisitorSession();

            return RenderCategoriesByParentCategory(parentCategory);
        }

        /// <summary>
        /// Takes a <c>parentCategory</c> parameter, representing the "RedirectUrl" name and pulls for the campaign category. 
        /// If available, all categories that are children of the parent category will be pulled and stored in the <c>ViewData</c>; then render the view to the product category page
        /// </summary>
        /// <param name="parentCategory"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        private ActionResult RenderCategoriesByParentCategory(string parentCategory)
        {
            string view = "AllProductsPage";

            CategoryView parentCampaignCategory = GetCampaignCategoryByCategoryName(parentCategory);

            if (!string.Equals(parentCampaignCategory.RedirectUrl, parentCategory, StringComparison.InvariantCultureIgnoreCase))
            {
                parentCampaignCategory = GetCampaignCategoryByCategoryName("products");
            }

            List<CategoryView> campaignCategories = categoryProductRouterEngine
                .GetChildCategoriesByParentCategory(parentCampaignCategory)
                .Where(c => DtmContext.CampaignProducts.Any(cp => cp.CategoryIndexer.Has(c.Code))).ToList();

            string productCategoryRoute = categoryProductRouterEngine.CreateRouteToProductCategoryPage(parentCategory);

            ViewData["CategoryProductRouterEngine"] = categoryProductRouterEngine;
            ViewData["ProductCategoryRoute"] = productCategoryRoute;
            ViewData["ParentCategory"] = parentCampaignCategory;
            ViewData["Categories"] = campaignCategories;

            List<CategoryProductRouter> categoryProducts = FilterCategoryProductsByCampaignCategories(campaignCategories);

            ViewData["CategoryProducts"] = categoryProducts.Skip(_paginate.GetSkipCountByPageParameter(Request["page"])).Take(_paginate.TakeCount).ToList();

            ViewData["Pages"] = _paginate.GetNumberOfPagesByList(categoryProducts);

            SetContextByPageCode(view);

            return View(view, Model);
        }

        /// <summary>
        /// Takes <c>campaignCategories</c> and returns a list of distinct category product entries
        /// </summary>
        /// <param name="campaignCategories"></param>
        /// <returns></returns>
        private List<CategoryProductRouter> FilterCategoryProductsByCampaignCategories(IEnumerable<CategoryView> campaignCategories)
        {
            List<CategoryProductRouter> categoryProducts = new List<CategoryProductRouter>();

            foreach (var campaignCategory in campaignCategories)
            {
                categoryProducts.AddRange(categoryProductRouterEngine.FilterCategoryProductsByCampaignCategory(campaignCategory));
            }

            return categoryProducts.Distinct(new ItemEqualityComparer()).ToList();
        }

        /// <summary>
        /// Takes a <c>campaignCategory</c> parameter and pulls for all related products; then models each product around the <c>CategoryProductRouter</c> object to provide the appropriate routing strings.
        /// </summary>
        /// <param name="campaignCategory"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        private ActionResult RenderProductsByCampaignCategory(CategoryView campaignCategory)
        {
            string view = "ProductListingPage";

            List<CategoryProductRouter> categoryProducts = categoryProductRouterEngine.FilterCategoryProductsByCampaignCategory(campaignCategory);

            CategoryView parentCampaignCategory = categoryProductRouterEngine.GetParentCategoryByChildCategory(campaignCategory);

            string productCategoryRoute = categoryProductRouterEngine.CreateRouteToProductCategoryPage(parentCampaignCategory.RedirectUrl);
            string productListingRoute = categoryProductRouterEngine.CreateRouteToProductListingPage(productCategoryRoute, campaignCategory);

            ViewData["ParentCategory"] = categoryProductRouterEngine.GetParentCategoryByChildCategory(campaignCategory);
            ViewData["ProductCategoryRoute"] = productCategoryRoute;
            ViewData["ProductListingRoute"] = productListingRoute;

            ViewData["Category"] = campaignCategory;
            ViewData["CategoryProducts"] = categoryProducts.Skip(_paginate.GetSkipCountByPageParameter(Request["page"])).Take(_paginate.TakeCount).ToList();
            ViewData["CategoryProductRouterEngine"] = categoryProductRouterEngine;

            ViewData["Pages"] = _paginate.GetNumberOfPagesByList(categoryProducts);

            SetContextByPageCode(view);

            return View(view, Model);
        }

        /// <summary>
        /// Takes a <c>category</c> parameter, representing the "RedirectUrl" name, and pulls for a campaign category matching that name.
        /// </summary>
        /// <param name="category"></param>
        /// <returns></returns>
        private CategoryView GetCampaignCategoryByCategoryName(string category)
        {
            CategoryView campaignCategory = DtmContext.CampaignCategories
            .FirstOrDefault(cc => string.Equals(cc.RedirectUrl, category, StringComparison.InvariantCultureIgnoreCase));

            return campaignCategory ?? new CategoryView();
        }

        /// <summary>
        /// Takes a <c>category</c> parameter, representing the "RedirectUrl" name along with the <c>parentCategory</c> parameter, representing the "RedirectUrl" name and pulls for the campaign category that is a child of the parent category name.
        /// </summary>
        /// <param name="category"></param>
        /// <param name="parentCategory"></param>
        /// <returns></returns>
        private CategoryView GetCampaignCategoryByParentCategoryName(string category, string parentCategory)
        {
            CategoryView parentCampaignCategory = GetCampaignCategoryByCategoryName(parentCategory);

            CategoryView campaignCategory = DtmContext.CampaignCategories
                .FirstOrDefault(
                cc => cc.ParentCategoryId == parentCampaignCategory.Id
                && string.Equals(cc.RedirectUrl, category, StringComparison.InvariantCultureIgnoreCase)
            );

            return campaignCategory ?? new CategoryView();
        }

        /// <summary>
        /// Assigns the campaign page based on the <c>pageCode</c> parameter.
        /// </summary>
        /// <param name="pageCode"></param>
        private void SetContextByPageCode(string pageCode)
        {
            PageDefinition campaignPage = DtmContext.CampaignPages.FirstOrDefault(cp => cp.PageCode == pageCode);

            if (campaignPage != null)
            {
                DtmContext.Page = campaignPage;
                DtmContext.PageCode = campaignPage.PageCode;
            }

            MapModelPageInformation();
        }

        /// <summary>
        /// Responsible for setting the DtmContext information.
        /// </summary>
        private void InitVisitorSession()
        {
            var context = EcommerceDataContextManager.Current;
            var visitorSession = Request.RequestContext.HttpContext.Request.Cookies.LoadVisitorSessionFromCookie();

            DtmContext.InitializeFromVisitorSession(visitorSession, DtmContext.OfferCode, DtmContext.Version, context);
        }

        /// <summary>
        /// Determines the current offer code and version number based on an optional query string parameter "cver", representing the Guid Campaign Offer Version Id, or defaults to an explicit offer version.
        /// </summary>
        private void SetOfferVersion()
        {
            Guid covid = Guid.TryParse(Request["cver"], out covid) ? covid : Guid.Empty;

            CampaignOfferVersionInformation offerVersion = DtmContext.CampaignOfferVersions.First(cov => cov.VersionIsDefault);

            if (covid != Guid.Empty && DtmContext.CampaignOfferVersions.Any(cov => cov.OfferVersionId == covid))
            {
                offerVersion = DtmContext.CampaignOfferVersions.First(cov => cov.OfferVersionId == covid);
            }

            DtmContext.OfferCode = offerVersion.OfferCode;
            DtmContext.Version = offerVersion.VersionNumber;
        }
    }

    internal class ItemEqualityComparer : IEqualityComparer<CategoryProductRouter>
    {
        public bool Equals(CategoryProductRouter x, CategoryProductRouter y)
        {
            return x.CampaignProduct.ProductCode == y.CampaignProduct.ProductCode;
        }

        public int GetHashCode(CategoryProductRouter obj)
        {
            return obj.CampaignProduct.ProductCode.GetHashCode();
        }
    }
}