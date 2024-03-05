using Dtm.Framework.Base.Caches.Models;
using Dtm.Framework.Base.Controllers;
using Dtm.Framework.Base.Models;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models.Ecommerce;
using FMLSHOP.BlogPosts;
using FMLSHOP.CategoryRouter;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;

namespace FMLSHOP.Controllers
{
    public class SitemapUrl
    {
        public string Loc { get; set; }
        public DateTime LastMod { get; set; }
        public string ChangeFreq { get; set; }
    }

    public class SitemapController : DtmContextController
    {
        private List<PageDefinition> _pages;

        private List<PageDefinition> Pages
        {
            get
            {
                if (_pages == null)
                {
                    List<int> pageTypeIds = new List<int>() { 1, 11, 22 };

                    _pages = DtmContext.CampaignPages.Where(p => p.PageTypeId.HasValue && pageTypeIds.Contains(p.PageTypeId.Value)).ToList();
                }

                return _pages;
            }
        }

        private readonly DomainInformation _SEODomain = DtmContext.CampaignDomains
                  .Where(d => d.IsSEO).FirstOrDefault();
        private List<SitemapUrl> GetProductPageUrls()
        {
            List<SitemapUrl> records = new List<SitemapUrl>();

            PageDefinition productCategoryPage = (Pages.FirstOrDefault(p => p.PageCode == "AllProductsPage") ?? new PageDefinition());
            PageDefinition productListingPage = (Pages.FirstOrDefault(p => p.PageCode == "ProductListingPage") ?? new PageDefinition());
            PageDefinition productDetailPage = (Pages.FirstOrDefault(p => p.PageCode == "ProductDetailPage") ?? new PageDefinition());

            CategoryProductRouterEngine categoryProductRouterEngine = new CategoryProductRouterEngine();

            // gather all parent categories
            List<CategoryView> parentCategories = categoryProductRouterEngine.ProductCategories.Where(pc => pc.ParentCategoryId == null).ToList();

            // gather all children categories
            List<Tuple<List<CategoryView>, string>> parentChildCategoryContext = parentCategories.Select(pc => new Tuple<List<CategoryView>, string>(
                categoryProductRouterEngine.GetChildCategoriesByParentCategory(pc), 
                categoryProductRouterEngine.CreateRouteToProductCategoryPage(pc.RedirectUrl)
                )).ToList();

            parentChildCategoryContext.ForEach(context =>
            {
                List<CategoryView> categories = context.Item1;
                string categoryRoute = context.Item2;

                // set the location of the P.C.P (a.k.a. product category page)
                records.Add(new SitemapUrl()
                {
                    Loc = _SEODomain.FullDomainCustomPath(categoryRoute),
                    LastMod = productCategoryPage.AddDate
                });

                categories.ForEach(category =>
                {
                    // set the location of the P.L.P (a.k.a. product listing page)
                    records.Add(new SitemapUrl()
                    {
                        Loc = _SEODomain.FullDomainCustomPath(categoryProductRouterEngine.CreateRouteToProductListingPage(categoryRoute, category)),
                        LastMod = productListingPage.AddDate
                    });

                    categoryProductRouterEngine.GetProductsByCategoryView(category).ForEach(categoryProduct =>
                    {
                        string productCode = categoryProduct.CampaignProduct.ProductCode
                        ;
                        var view = ViewEngines.Engines.FindPartialView(this.ControllerContext, productCode).View;

                        // set the location of the P.D.P. (a.k.a. product detail page)
                        records.Add(new SitemapUrl()
                        {
                            Loc = _SEODomain.FullDomainCustomPath(categoryProduct.RouteToProductDetailPage),
                            LastMod = productDetailPage.AddDate
                        });
                    });
                });
            });

            return records;
        }

        private List<SitemapUrl> GetBlogArticleUrls()
        {
            List<SitemapUrl> records = new List<SitemapUrl>();

            PageDefinition blogPage = (Pages.FirstOrDefault(p => p.PageCode == "Blog") ?? new PageDefinition());
            PageDefinition articlePage = (Pages.FirstOrDefault(p => p.PageCode == "Article") ?? new PageDefinition());

            BlogPostsEngine blogPostsEngine = new BlogPostsEngine();

            List<BlogPostView> blogPosts = blogPostsEngine.GetBlogPosts(0, 100).ToList();

            List<string> tags = blogPosts.SelectMany(blogPost => blogPost.Tags.Select(bt => blogPostsEngine.GetParentRoute(bt))).Distinct().ToList();

            // set the location of each blog tag page
            tags.ForEach(tag =>
            {
                records.Add(new SitemapUrl()
                {
                    Loc = _SEODomain.FullDomainCustomPath(tag),
                    LastMod = blogPage.AddDate
                });
            });

            List<string> categories = blogPosts.SelectMany(blogPost => blogPost.Categories.Select(bc => blogPostsEngine.GetCategoryRoute(blogPost))).Distinct().ToList();

            // set the location of each blog category page
            categories.ForEach(category =>
            {
                records.Add(new SitemapUrl()
                {
                    Loc = _SEODomain.FullDomainCustomPath(category),
                    LastMod = blogPage.AddDate
                });
            });

            // set the location of each blog article page
            blogPosts.ForEach(blogPost =>
            {
                records.Add(new SitemapUrl() { 
                    Loc = _SEODomain.FullDomainCustomPath(blogPostsEngine.GetPermalink(blogPost)),
                    LastMod = blogPost.ChangeDate
                });
            });

            return records;
        }

        private List<SitemapUrl> GetPageUrls()
        {
            List<SitemapUrl> records = new List<SitemapUrl>();

            List<string> exclusionPageCodes = new List<string>() {
                "Index",
                "AllProductsPage", 
                "ProductCategoryPage", 
                "ProductDetailPage", 
                "ProductListingPage", 
                "Blog", 
                "Article",
                "SearchResults",
                "QR",
                "ShoppingCart"
            };

            Pages.Where(p => !exclusionPageCodes.Contains(p.PageCode)).ToList().ForEach(page =>
            {
                records.Add(new SitemapUrl()
                {
                    Loc = _SEODomain.FullDomainCustomPathContext(page.PageAlias ?? page.PageCode) + DtmContext.ApplicationExtension,
                    LastMod = page.AddDate
                });
            });

            return records;
        }

        private List<SitemapUrl> GetAllUrls()
        {
            return new List<SitemapUrl>()
            {
                new SitemapUrl()
                {
                    Loc = _SEODomain.FullDomain,
                    LastMod = (Pages.FirstOrDefault(p => p.PageCode == "Index") ?? new PageDefinition()).AddDate
                }
            }
            .Concat(GetPageUrls())
            .Concat(GetProductPageUrls())
            .Concat(GetBlogArticleUrls()).ToList();
        }

        public ActionResult SitemapXml()
        {
            if (DtmContext.IsProxyIpAddress)
                throw new HttpException((int)HttpStatusCode.NotFound, "Sitemap.xml does not exist on proxy.");

            if (string.IsNullOrWhiteSpace(_SEODomain.FullDomain))
            {
                new SiteExceptionHandler("Sitemap.xml SEO domain is not configured.");
                return Content("Not configured.");
            }

            XDocument doc = new XDocument(
                new XDeclaration("1.0", "UTF-8", string.Empty),
                new XElement("urlset",
                    new XAttribute("nsattr", "http://www.google.com/schemas/sitemap/0.9"),
                    GetAllUrls().Select(u => new XElement("url",
                    new XElement("loc", u.Loc),
                    new XElement("lastmod", u.LastMod.ToString("yyyy-MM-dd")),
                    new XElement("changefreq", "monthly"),
                    new XElement("priority", "0.5")
                    ))));

            StringBuilder xmlBuilder = new StringBuilder();

            xmlBuilder.AppendLine(doc.Declaration.ToString().Replace("standalone=\"\"", string.Empty));
            xmlBuilder.AppendLine(doc.ToString().Replace("nsattr", "xmlns"));

            Response.Cache.SetCacheability(HttpCacheability.Public);

            return Content(xmlBuilder.ToString(), "text/xml");
        }
    }
}