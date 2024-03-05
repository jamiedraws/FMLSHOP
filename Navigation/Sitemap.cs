using Dtm.Framework.ClientSites.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FMLSHOP.Navigation
{
    public class Sitemap
    {
        /// <summary>
        /// Represents a complete, collection of destinations for a single website 
        /// </summary>
        public NavigationList SitemapList;
        /// <summary>
        /// A dictionary of all destinations and landmarks for a single website
        /// </summary>
        public Sitemap()
        {
            SitemapList = new NavigationList();

            // Home
            SitemapList.AddItem(new NavigationItem
            {
                Id = "home",
                Name = "Home",
                Page = "Index",
                Hash = "#main"
            });

            // FAQ
            SitemapList.AddItem(new NavigationItem
            {
                Id = "faq",
                Name = "FAQ",
                Page = "FAQ",
                Hash = "#main"
            });

            // Customer Service
            SitemapList.AddItem(new NavigationItem
            {
                Id = "customer-service",
                Name = "Customer Service",
                Page = "Customer-Service",
                Hash = "#main"
            });

            // Terms
            SitemapList.AddItem(new NavigationItem
            {
                Id = "terms",
                Name = "Terms of Service",
                Page = "TermsOfService",
                Route = string.Format("{0}/{1}/TermsOfService", DtmContext.OfferCode, DtmContext.Version),
                Hash = "#main"
            });

            // Purchasing Policy
            SitemapList.AddItem(new NavigationItem
            {
                Id = "purchasing-policy",
                Name = "Purchasing Policy",
                Page = "Purchasing-Policy",
                Hash = "#main"
            });

            // Shipping Policy
            SitemapList.AddItem(new NavigationItem
            {
                Id = "shipping-policy",
                Name = "Shipping Policy",
                Page = "Shipping-Policy",
                Hash = "#main"
            });

            // Return Policy
            SitemapList.AddItem(new NavigationItem
            {
                Id = "return-policy",
                Name = "Return Policy",
                Page = "Return-Policy",
                Route = string.Format("{0}/{1}/Return-Poilicy", DtmContext.OfferCode, DtmContext.Version),
                Hash = "#main"
            });

            // Security Policy
            SitemapList.AddItem(new NavigationItem
            {
                Id = "security-policy",
                Name = "Security Policy",
                Page = "Security-Policy",
                Hash = "#main"
            });

            // Privacy Policy
            SitemapList.AddItem(new NavigationItem
            {
                Id = "privacy-policy",
                Name = "Privacy Policy",
                Page = "Privacy-Policy",
                Hash = "#main"
            });

            // Site Map
            SitemapList.AddItem(new NavigationItem
            {
                Id = "sitemap",
                Name = "Site Map",
                Page = "SiteMap",
                Hash = "#main"
            });

            // Order Now
            SitemapList.AddItem(new NavigationItem
            {
                Id = "order-now",
                Name = "Order Now",
                Hash = "#order"
            });

            // Real People Reviews
            SitemapList.AddItem(new NavigationItem
            {
                Id = "reviews",
                Name = "Real People Reviews",
                Page = "Index",
                Hash = "#reviews",
                ApplyHash = true
            });

            // Feel Good Blog
            SitemapList.AddItem(new NavigationItem
            {
                Id = "blog",
                Name = "Feel Good Blog",
                Page = "Blog",
                Route = string.Format("Articles?cver={0}", DtmContext.VersionId),
                Hash = "#main"
            });

            // Our Science (Gateway)
            SitemapList.AddItem(new NavigationItem
            {
                Id = "science-gateway",
                Name = "Our Science",
                Page = "Index",
                Hash = "#science",
                ApplyHash = true
            });

            // Our Science
            SitemapList.AddItem(new NavigationItem
            {
                Id = "science",
                Name = "Our Science",
                Page = "Science",
                Hash = "#main"
            });

            // Our Story (Gateway)
            SitemapList.AddItem(new NavigationItem
            {
                Id = "story-gateway",
                Name = "Our Story",
                Page = "Index",
                Hash = "#story",
                ApplyHash = true
            });

            // Our Story
            SitemapList.AddItem(new NavigationItem
            {
                Id = "story",
                Name = "Our Story",
                Page = "Story",
                Hash = "#main"
            });

            // Track Your Order
            SitemapList.AddItem(new NavigationItem
            {
                Id = "track-your-order",
                Name = "Track Your Order",
                Page = "https://customerstatus.com/SearchUpdate.aspx",
                IsExternal = true
            });

            // Guarantee
            SitemapList.AddItem(new NavigationItem
            {
                Id = "shipping-return",
                Name = "Shipping + Returns",
                Page = "Shipping-Returns",
                Hash = "#main"
            });

            // Articles
            SitemapList.AddItem(new NavigationItem
            {
                Id = "articles",
                Name = "Press",
                Page = "Blog",
                Route = string.Format("Articles?cver={0}", DtmContext.VersionId),
                Hash = "#main"
            });

            // Account
            SitemapList.AddItem(new NavigationItem
            {
                Id = "account",
                Name = "Account",
                Route = string.Format("{0}/{1}/Account/Index", DtmContext.OfferCode, DtmContext.Version)
            });

            // Login
            SitemapList.AddItem(new NavigationItem
            {
                Id = "login",
                Name = "Log In",
                Route = string.Format("{0}/{1}/Account/Login", DtmContext.OfferCode, DtmContext.Version)
            });

            // Create Account
            SitemapList.AddItem(new NavigationItem
            {
                Id = "create-account",
                Name = "Create an Account",
                Route = string.Format("{0}/{1}/Profile/CreateAccount", DtmContext.OfferCode, DtmContext.Version)
            });

            // Cart
            SitemapList.AddItem(new NavigationItem
            {
                Id = "cart",
                Name = "Cart",
                Page = "Checkout",
                Hash = "#main",
            });

            // Products
            SitemapList.AddItem(new NavigationItem
            {
                Id = "products",
                Name = "Products",
                Route = string.Format("products?cver={0}", DtmContext.VersionId)
            });

            // Facebook
            SitemapList.AddItem(new NavigationItem
            {
                Id = "facebook",
                Name = "Facebook",
                Route = "https://www.facebook.com/groups/3590130034550725",
                IsExternal = true
            });

            SitemapList.AddItem(new NavigationItem
            {
                Id = "facebook-conversation",
                Name = "Join the Conversation",
                Page = "https://www.facebook.com/groups/3590130034550725",
                IsExternal = true
            });

            // Instagram
            SitemapList.AddItem(new NavigationItem
            {
                Id = "instagram",
                Name = "Instagram",
                Route = "https://www.instagram.com/flipmylifenow/",
                IsExternal = true
            });

            // YouTube
            SitemapList.AddItem(new NavigationItem
            {
                Id = "youtube",
                Name = "YouTube",
                Route = "https://www.youtube.com/c/FlawlessBeauty",
                IsExternal = true
            });

            // TikTok
            SitemapList.AddItem(new NavigationItem
            {
                Id = "tiktok",
                Name = "TikTok",
                Route = "https://www.tiktok.com/@flawlessbeauty",
                IsExternal = true
            });
        }

    }
}