using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;
using FMLSHOP.Classes;
using FMLSHOP.PromoCodeHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace FMLSHOP
{
    public class MvcApplication : ClientSiteApplication
    {
        protected override void OnAppStart()
        {
            //10% off promo codes
            var tenPercentOffPromoCodes = new List<string>()
            {
                "MICHAELJUSTIN10", "SILVERSTORM10", "LISALOU10", "SALINA10", "BLUECOLLAR10", 
                "CATHERINE10", "GARRETT10", "WORTHY10", "KIMHALE10","DANNA10", "MONICA10", "ANGEL10", "NADIA10", 
                "MELISSA10", "ERIN10", "ERINSJOURNEY10", "MISTI10", "SHANTEL10","WELLMICHELLE10", "NICOLEHAPPY10", 
                "FALON10", "MARCELLE10", "PAUL10", "MANU10", "HAZELEYES10", "MAMABIRD10", "ORIE10", "FARRAH10", "GEANINE10", "FLIP10",
                "MANIFEST", "CAKE10", "STRONGRUN10", "MIL10", "CHICNESS10", "BENEDIKT10", "BEAUTY10", "THEBROWN10", "CANADATRIBE10", "JENNIFERLOVAS10", "VANESSACUTTING10",
                "MICKI10", "CARLEENEUMAN10", "BANTON10", "BRITTNEYK10", "MICH5810", "MILIDIME10", "CALIENTEFITNESS10", "MONICAW10", "ROSINA10", "FASHIONHAPPY10", "THEHEALTHGOAT10", "NANALACOVE10", "ASHLEY10",
                "WELCOME10"
            };

            foreach (var promoCode in tenPercentOffPromoCodes)
            {
                DtmContext.PromoCodeRules.Add(new PromoCodeRule(promoCode, PromoCodeRuleType.AddDiscountPercent, promoCode, (decimal)0.1, 1));
            }
            PromoCodeItems.ExcludedItems.AddPromoCodeProducts("FLIPMYLIFENOW", new List<string>() { "CF7C", "CF7V", "CCPB", "CSML", "CMEG", "CIMU", "CRLX", "CBBP", "CBRN", "SHIP", "SHIPSUB" });
            DtmContext.PromoCodeRules.Add(new PromoCodeRule("FLIPMYLIFENOW", PromoCodeRuleType.Custom, "FLIPMYLIFENOW_Custom", .25M, 1));
            DtmContext.PromoCodeRules.Add(new PromoCodeRule("FLIPMYLIFENOW_Custom", PromoCodeRuleType.ProductTransactionFee, "FLIPMYLIFENOW", .25M, 1));

            DtmContext.PromoCodeRules.Add(new PromoCodeRule("BEAUTYGLOWUP", PromoCodeRuleType.AddDiscountPercent, "BEAUTYGLOWUP", 0.20M ,1));


            DtmContext.PromoCodeRules.Add(new PromoCodeRule("AMBASSADOR25", PromoCodeRuleType.AddDiscountPercent, "AMBASSADOR25", .25M, 1));
            DtmContext.PromoCodeRules.Add(new PromoCodeRule("PROMOCODE25", PromoCodeRuleType.AddDiscountPercent, "PROMOCODE25", .25M, 1, DateTime.Parse("06/1/23"), DateTime.Parse("06/04/23 11:59 PM")));
        }

        protected override void ConfigureAdditionalRoutes(RouteCollection routes)
        {
            var offerRegex = string.Format("({0})", string.Join("|", DtmContext.CampaignOfferVersions
                .Select(cov => cov.OfferCode)
                .Distinct()));
            var versionRegex = string.Format("({0})", string.Join("|", DtmContext.CampaignOfferVersions
              .Select(cov => cov.VersionNumber)
              .Distinct()));

            routes.MapRoute("OfferAccountRoutes",
             "{offer}/{version}/Account/{action}/{id}",
                new { controller = "Account", action = "Index", pageCode = "Login", id = UrlParameter.Optional },
                new { offer = offerRegex, version = versionRegex });

            routes.MapRoute("AddAddress", "Profile/AddAddress",
                new { controller = "Profile", action = "AddAddress" });

            routes.MapRoute("EditAddress", "Profile/EditAddress",
                new { controller = "Profile", action = "EditAddress" });

            routes.MapRoute("RemoveAddress", "Profile/RemoveAddress",
                new { controller = "Profile", action = "DeleteAddress" });

            routes.MapRoute("AddAddressOfferVersion", "{offer}/{version}/Profile/AddAddress",
               new { controller = "Profile", action = "AddAddress" },
               new { offer = offerRegex, version = versionRegex });

            routes.MapRoute("EditAddressOfferVersion", "{offer}/{version}/Profile/EditAddress",
                new { controller = "Profile", action = "EditAddress" },
                new { offer = offerRegex, version = versionRegex });

            routes.MapRoute("RemoveAddressOfferVersion", "{offer}/{version}/Profile/RemoveAddress",
                new { controller = "Profile", action = "DeleteAddress" },
                new { offer = offerRegex, version = versionRegex });

            routes.MapRoute("RegisterProfile", "Profile/CreateAccount/{accountType}",
                new { controller = "Profile", action = "CreateAccount", accountType = AccountType.Consumer });

            routes.MapRoute("RegisterProfileOfferVersion", "{offer}/{version}/Profile/CreateAccount/{accountType}",
                new { controller = "Profile", action = "CreateAccount", accountType = AccountType.Consumer },
                new { offer = offerRegex, version = versionRegex });

            routes.MapRoute("SetDefault", "Profile/SetDefault",
                new { controller = "Profile", action = "SetDefault" });

            routes.MapRoute("SetDefaultOfferVersion", "{offer}/{version}/Profile/SetDefault",
                new { controller = "Profile", action = "SetDefault" },
                new { offer = offerRegex, version = versionRegex });

            routes.MapRoute("CheckoutLogin", "Profile/Checkout", new { controller = "Profile", action = "CheckoutLogin" });
            routes.MapRoute("ProfileLogin", "Profile/Login", new { controller = "Profile", action = "LoginAccount" });
            routes.MapRoute("ProfileLogout", "Profile/Logout", new { controller = "Profile", action = "LogoutAccount" });
            routes.MapRoute("ProfileLogoutRedirect", "Profile/Logout/{redirectOverride}", new { controller = "Profile", action = "LogoutAccount", redirectOverride = string.Empty });

            routes.MapRoute("ExclusiveContent", "Profile/ExclusiveContent", new { controller = "Profile", action = "GetExclusiveContent" });

            routes.MapRoute("DynamicCategory", "GetCategory", new { controller = "Category", action = "RenderCategory" });
            routes.MapRoute("DynamicPage", "GetPage", new { controller = "Page", action = "RenderPage" });
            routes.MapRoute("Search", "Search", new { controller = "Search", action = "Search" });

            // Article blogs
            routes.MapRoute("Articles", "Articles", new { controller = "Articles", action = "GetPosts", tagSlug = "Articles" });
            routes.MapRoute("CategoryArticles", "Articles/{categorySlug}", new { controller = "Articles", action = "GetPostsByCategory", tagSlug = "Articles" });
            routes.MapRoute("Article", "Articles/{categorySlug}/{urlSlug}", new { controller = "Articles", action = "GetPost", tagSlug = "Articles" });

            routes.MapRoute("ProductCategory", "Products", new { controller = "CategoryProduct", action = "ProductCategoryPage", parentCategory = "Products" });
            routes.MapRoute("ProductListing", "Products/{category}", new { controller = "CategoryProduct", action = "ProductListingPage", parentCategory = "Products" });
            routes.MapRoute("ProductDetail", "Products/{category}/{productSlug}", new { controller = "CategoryProduct", action = "ProductDetailPage", parentCategory = "Products" });

            routes.MapRoute("OfferVersionCheckoutLogin", "{offer}/{version}/Profile/Checkout", new { controller = "Profile", action = "CheckoutLogin" }, new { offer = offerRegex, version = versionRegex });
            routes.MapRoute("OfferVersionProfileLogin", "{offer}/{version}/Profile/Login", new { controller = "Profile", action = "LoginAccount" }, new { offer = offerRegex, version = versionRegex });
            routes.MapRoute("OfferVersionProfileLogout", "{offer}/{version}/Profile/Logout", new { controller = "Profile", action = "LogoutAccount" }, new { offer = offerRegex, version = versionRegex });
            routes.MapRoute("OfferVersionProfileLogoutRedirect", "{offer}/{version}/Profile/Logout/{redirectOverride}", new { controller = "Profile", action = "LogoutAccount", redirectOverride = string.Empty }, new
            {
                offer = offerRegex,
                version = versionRegex
            });

            routes.MapRoute("OfferVersionDynamicCategory", "{offer}/{version}/GetCategory", new { controller = "Category", action = "RenderCategory" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });
            routes.MapRoute("OfferVersionDynamicPage", "{offer}/{version}/GetPage", new { controller = "Page", action = "RenderPage" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });
            routes.MapRoute("OfferVersionSearch", "{offer}/{version}/Search", new { controller = "Search", action = "Search" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });

            // Article blogs
            routes.MapRoute("OfferVersionArticles", "{offer}/{version}/Articles", new { controller = "Articles", action = "GetPosts", tagSlug = "Articles" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });
            routes.MapRoute("OfferVersionCategoryArticles", "{offer}/{version}/Articles/{categorySlug}", new { controller = "Articles", action = "GetPostsByCategory", tagSlug = "Articles" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });
            routes.MapRoute("OfferVersionArticle", "{offer}/{version}/Articles/{categorySlug}/{urlSlug}", new { controller = "Articles", action = "GetPost", tagSlug = "Articles" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });

            routes.MapRoute("OfferVersionProductCategory", "{offer}/{version}/Products", new { controller = "CategoryProduct", action = "ProductCategoryPage", parentCategory = "Products" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });
            routes.MapRoute("OfferVersionProductListing", "{offer}/{version}/Products/{category}", new { controller = "CategoryProduct", action = "ProductListingPage", parentCategory = "Products" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });
            routes.MapRoute("OfferVersionProductDetail", "{offer}/{version}/Products/{category}/{productSlug}", new { controller = "CategoryProduct", action = "ProductDetailPage", parentCategory = "Products" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });

            // Ingredient views
            routes.MapRoute("OfferVersionIngredients", "{offer}/{version}/Ingredients/{ingredient}", new { controller = "Ingredient", action = "RenderIngredientViewBySlug" }, new
            {
                offer = offerRegex,
                version = versionRegex
            });

            routes.MapRoute("Ingredients", "Ingredients/{ingredient}", new { controller = "Ingredient", action = "RenderIngredientViewBySlug" });

            var defaultSitemapRoute = routes["Sitemap.xml"];
            if (defaultSitemapRoute != null)
            {
                routes.Remove(defaultSitemapRoute);
            }

            routes.MapRoute("Sitemap", "Sitemap.xml", new { controller = "Sitemap", action = "SitemapXml" });

            base.ConfigureAdditionalRoutes(routes);
        }


    }
}