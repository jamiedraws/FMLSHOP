<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="FMLSHOP.LimitedTimeOffer" %>

<%
    bool isFrontPage = DtmContext.Page.IsStartPageType;
    bool isShoppingCartPage = string.Equals("shoppingcart", DtmContext.PageCode, StringComparison.InvariantCultureIgnoreCase);

    string productName = SettingsManager.ContextSettings["Label.ProductName"];

    NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
    NavigationItem index = sitemap.GetItemById("index");
%>

<div class="slide slide--ugc-photo">
    <div class="slide__into" tabindex="0" id="ugc-photo-carousel">
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20-(2).webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20-(2).jpg" loading="lazy" alt="" width="480" height="640">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20-(3).webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20-(3).jpg" loading="lazy" alt="" width="480" height="800">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20-(4).webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20-(4).jpg" loading="lazy" alt="" width="480" height="640">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20.webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-20.jpg" loading="lazy" alt="" width="480" height="640">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-21-(2).webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-21-(2).jpg" loading="lazy" alt="" width="480" height="640">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-21.webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-21.jpg" loading="lazy" alt="" width="480" height="641">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39-(2).webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39-(2).jpg" loading="lazy" alt="" width="480" height="855">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39-(3).webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39-(3).jpg" loading="lazy" alt="" width="480" height="640">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39-(4).webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39-(4).jpg" loading="lazy" alt="" width="480" height="829">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39.webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-39.jpg" loading="lazy" alt="" width="480" height="853">
        </picture>
        <picture class="slide__item">
            <source srcset="/images/Site1/ugc-photo/photo_2023-05-16_16-53-40.webp" type="image/webp">
            <img src="/images/Site1/ugc-photo/photo_2023-05-16_16-53-40.jpg" loading="lazy" alt="" width="480" height="639">
        </picture>
    </div>
    <div class="slide__nav">
        <button aria-label="Previous" class="slide__prev" type="button">
            <svg class="icon">
                <use href="#icon-chevron"></use>
            </svg>
        </button>
        <button aria-label="Next" class="slide__next" type="button">
            <svg class="icon">
                <use href="#icon-chevron"></use>
            </svg>
        </button>
    </div>
</div>

<footer aria-label="Social media, shop, help and special offers" class="view footer footer--container footer--wave section @print-only-hide">
    <div id="footer" class="view__anchor"></div>
    <div class="view__in footer__in section__in">
        <div class="footer__group">
            <div class="footer footer--logo-social">
                <div class="footer__group">
                    <a href="<%= index.Page %>" aria-label="<%= productName %>" class="footer__logo">
                        <svg class="icon icon--logo">
                            <use href="#logo"></use>
                        </svg>
                    </a>
                    <%
                        List<NavigationItem> socialItems = sitemap.GetItemsByIdRange(new List<string>
                        {
                            "instagram",
                            "facebook"
                        });

                        if (socialItems.Any())
                        {
                            %>
                            <p class="footer__text">Follow us for Tips/Tricks &amp; giveaways</p>
                            <%
                                socialItems.ForEach(socialItem =>
                                {
                                %>
                                <a href="<%= socialItem.Route %>" class="footer__icon" aria-label="<%= socialItem.Name %>" target="_blank">
                                    <svg class="icon icon--social">
                                        <use href="#icon-<%= socialItem.Id %>"></use>
                                    </svg>
                                </a>
                                <%
                            });
                                    }
                    %>
                </div>
            </div>
            <%
                Func<List<string>, string> renderNavigationLinks = ((List<string> ids) =>
                {
                    string HTML = string.Empty;

                    List<NavigationItem> candidates = sitemap.GetItemsByIdRange(ids);

                    candidates.ForEach(candidate =>
                    {
                        if (candidate.IsExternal)
                        {
                            HTML += string.Format(@"<a class=""link"" href=""{0}"" target=""_blank"">{1}<span class=""link__advisal""> <span class=""link__container"">Opens in a new window</span></span></a>", candidate.Page, candidate.Name);
                        }
                        else
                        {
                            HTML += string.Format(@"<a href=""{0}"">{1}</a>", candidate.Page, candidate.Name);
                        }
                    });

                    return HTML;
                });

                CategoryProductRouterEngine categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

                Func<string, string> renderProductListingLink = ((string categoryCode) =>
                {
                    string HTML = string.Empty;

                    var captureCampaignCategory = categoryProductRouterEngine.ProductCategories.Where(pc => pc.Code.Equals(categoryCode));

                    if (captureCampaignCategory.Any())
                    {
                        var campaignCategory = captureCampaignCategory.FirstOrDefault();
                        var parentCampaignCategory = categoryProductRouterEngine.GetParentCategoryByChildCategory(campaignCategory);

                        HTML = string.Format(@"<a href=""{0}?cver={1}"">{2}</a>",
                            categoryProductRouterEngine.CreateRouteToProductListingPage(categoryProductRouterEngine.CreateRouteToProductCategoryPage(parentCampaignCategory.RedirectUrl), campaignCategory),
                            DtmContext.VersionId,
                            campaignCategory.Name);
                    }

                    return HTML;
                });
            %>
            <% if (isFrontPage)
                { %>
            <div class="footer footer--sitemap">
                <div class="footer__group">
                    <nav class="footer__list" aria-labelledby="footer-shop-title">
                        <h2 class="footer__title" id="footer-shop-title">Shop</h2>
                        <%
                            Response.Write(renderNavigationLinks(new List<string> {
                                "products",
                                "reviews",
                                "blog",
                                "science",
                                "story",
                                "facebook-conversation"
                            }));
                        %>
                    </nav>
                    <nav class="footer__list" aria-labelledby="footer-help-title">
                        <h2 class="footer__title" id="footer-help-title">Help</h2>
                        <%
                            List<string> helpLinks = new List<string> {
                                "customer-service",
                                "shipping-policy",
                                "about",
                                "faq"
                            };

                            if (FMLSHOP.Rules.Expose.Login)
                            {
                                helpLinks.Add("account");
                            }

                            helpLinks.Add("sitemap");

                            Response.Write(renderNavigationLinks(helpLinks));
                        %>
                    </nav>
                </div>
            </div>
            <div class="footer__item view">
                <div id="join-the-ageless-generation" class="view__anchor"></div>
                <%= Html.Partial("Email-Signup") %>
            </div>
            <% } %>
        </div>

        <div class="footer__legal">
            <p>&copy; Flip My Life Wellness, Inc. | All rights reserved | 
                <%
                    Response.Write(renderNavigationLinks(new List<string> {
                    "terms",
                    "privacy-policy"
                }));
            %> | <span class="onetrust-privacy"></span>
            </p>
            <p>Web by: <a href="https://www.digitaltargetmarketing.com/" target="_blank" title="View the agency behind this site, opens in a new tab">Digital Target Marketing</a></p>
        </div>

        <%if (HttpContext.Current.Request.Url.AbsolutePath.Contains("/Checkout"))
            { %>
        <script>
            (function () {
                let emailOptIn = document.getElementById("EmailOptIn");
                let emailOptInCbx = document.getElementById("EmailOptInCbx");
                if (emailOptInCbx != 'undefined' && emailOptInCbx != null) {
                    emailOptInCbx.addEventListener("click", function () {
                        if (this.checked) {
                            emailOptIn.value = "True";
                        } else {
                            emailOptIn.value = "False";
                        }
                    });
                }
            })();
        </script>
        <% } %>
    </div>  
</footer>

<span hidden>
    <svg>
        <symbol id="logo" x="0px" y="0px" viewBox="0 0 496.8 474">
            <path d="M277.8,382.3v72h43.4l1.3-10.8h-33v-61.2H277.8z M332.1,454.4h11.8v-72h-11.8V454.4z M360.6,382.3v72h11.8V423h28.2V413
            h-28.2v-20.2H403l-1.2-10.4H360.6z M415.6,382.3v72h42.7l1.1-10.4h-32v-21.4h29.4v-10.2h-29.4v-19.7h32l-1.1-10.4H415.6z M3.1,311.5
            v143.2h244.3v-40H141.2v-95.6H107v95.6H38.3V310.8L3.1,311.5z M338,289.8l-22.3,45h-0.2l-22.5-45h-15.3v72h11.6l-0.1-56.9h0.2
            l25.1,49.3h1.8l25.1-49.3h0.2l-0.1,56.9h11.6v-72H338z M410.4,289.8l-9.9,18.5c-2.4,4.9-5.1,9.6-7.6,14.3h-0.3
            c-2.5-4.8-5.2-9.5-7.7-14.4l-9.9-18.4h-13.5l25.3,42.8v29.2h11.8v-29.2l25.3-42.8H410.4z M210,111.5v114.2H3.1v40h244.3V111.5H210z
             M317.3,55.2h28.3c35.5,0,51.8,11.7,51.8,40c0,27.3-16.2,39.3-51.8,39.3h-28.3V55.2z M276.9,21.4v244.3h40.4v-97.7h36.2
            c53.1,0,83.5-26.6,83.5-72.8c0-48-29.3-73.8-85.9-73.8H276.9z M229,19.3c-14.1,0-24.8,10-24.8,23.1c0,13.8,10.7,23.5,24.8,23.5
            c13.8,0,24.5-9.7,24.5-23.1C253.5,29.4,242.8,19.3,229,19.3z"/>
            <path d="M446.9,21.2v2.6h8.9v21.4h3V23.8h8.9v-2.6H446.9z M493.4,21.2l-2.9,4.1l-6.9,9.6l-6.9-9.6l-2.9-4.1h-2.6v24h3v-19l2.3,3.5
            l7.1,9.9l7-9.9c0.9-1.3,1.7-2.5,2.4-3.5v19h3v-24H493.4z"/>
        </symbol>

        <symbol id="icon-person" x="0px" y="0px" viewBox="0 0 36 36" style="enable-background:new 0 0 36 36;">
            <style>
                #icon-person path {
                    fill: currentColor;
                    stroke: none;
                }
            </style>
            <path d="M3,31.2c2-1.9,4.3-3.4,6.8-4.5c2.5-1.1,5.3-1.7,8.2-1.7s5.7,0.6,8.2,1.7c2.5,1.1,4.8,2.7,6.8,4.5V3H3V31.2z M18.1,21
            c1.9,0,3.6-0.7,4.9-2c1.3-1.3,2-3,2-4.9s-0.7-3.6-2-4.9s-3-2-4.9-2s-3.6,0.7-4.9,2s-2,3-2,4.9s0.7,3.6,2,4.9
            C14.5,20.3,16.2,21,18.1,21z M3,36c-0.8,0-1.5-0.3-2.1-0.9C0.3,34.5,0,33.8,0,33V3c0-0.8,0.3-1.5,0.9-2.1S2.2,0,3,0h30
            c0.8,0,1.5,0.3,2.1,0.9C35.7,1.5,36,2.2,36,3v30c0,0.8-0.3,1.5-0.9,2.1C34.5,35.7,33.8,36,33,36H3z M5.8,33h24.5v-0.5
            c-1.8-1.5-3.7-2.7-5.8-3.5s-4.2-1.2-6.5-1.2s-4.4,0.4-6.5,1.2s-4,1.9-5.8,3.5L5.8,33z M18.1,18c-1.1,0-2-0.4-2.8-1.1
            s-1.1-1.7-1.1-2.8c0-1.1,0.4-2,1.1-2.8s1.7-1.1,2.8-1.1c1.1,0,2,0.4,2.8,1.1S22,13,22,14c0,1.1-0.4,2-1.1,2.8S19.2,17.9,18.1,18z"/>
        </symbol>

        <symbol id="icon-chevron" x="0px" y="0px" viewBox="0 0 5.3 8.2" style="enable-background:new 0 0 5.3 8.2;">
            <path d="M0.8,4.2 M0.8,4.2L4,1 M4,7.4L0.8,4.2"/>
        </symbol>

        <symbol id="icon-double-chevron" viewBox="0 0 26.75 24">
            <path d="m24.65,0l2.1,2.1-9.9,9.9,9.9,9.9-2.1,2.1-12-12L24.65,0Zm-12.65,0l2.1,2.1L4.2,12l9.9,9.9-2.1,2.1L0,12,12,0Z"/>
        </symbol>

        <symbol id="icon-plus" x="0px" y="0px" viewBox="0 0 11 11" style="enable-background:new 0 0 11 11;">
            <path d="M10.1,5.5H5.5v4.6 M5.5,5.5H0.9 M5.5,0.9v4.6"/>
        </symbol>

        <symbol id="icon-minus" x="0px" y="0px" viewBox="0 0 11 11" style="enable-background:new 0 0 11 11;">
            <path d="M10.1,5.5H5.4 M5.4,5.5H0.7 M5.4,5.5"/>
        </symbol>

        <symbol id="icon-cart" x="0px" y="0px" viewBox="0 0 24.6 24.6" style="enable-background:new 0 0 24.6 24.6;">
            <style>
                #icon-cart path {
                    fill: currentColor;
                    stroke: none;
                }
            </style>
            <path d="M24.2,5.8h-19c0,0-0.1-3.2-1.3-4.5C3,0.4,1.8-0.1,0.5,0l0,0C0.2,0,0,0.2-0.1,0.5c0,0.3,0.2,0.6,0.5,0.6c0,0,0.1,0,0.1,0
            C2,1,3.3,1.9,3.6,3.4c0.3,1.2,1.9,13.1,2.3,15.7c-1.5,0.7-2.1,2.4-1.4,3.9c0.7,1.5,2.4,2.1,3.9,1.4c1-0.5,1.7-1.5,1.7-2.6
            c0-0.5-0.1-0.9-0.4-1.4h7.1c-0.2,0.4-0.4,0.9-0.4,1.4c0,1.6,1.3,2.9,2.9,2.9c1.6,0,2.9-1.3,2.9-2.9c0-1.6-1.3-2.9-2.9-2.9H7.2
            l-0.6-3.5h12.7c1.6,0.1,3-0.9,3.3-2.5c0.3-1.3,1.5-5,2-6.4c0.1-0.2,0-0.4-0.3-0.5C24.3,5.8,24.2,5.8,24.2,5.8z"/>
        </symbol>

        <symbol id="icon-location" x="0px" y="0px" viewBox="0 0 32 40">
            <style>
                #icon-location path {
                    fill: currentColor;
                    stroke: none;
                }
            </style>
            <path d="M16,19.5c1,0,1.8-0.3,2.5-1c0.7-0.7,1-1.5,1-2.5s-0.3-1.8-1-2.5c-0.7-0.7-1.5-1-2.5-1s-1.8,0.3-2.5,1c-0.7,0.7-1,1.5-1,2.5
            s0.3,1.8,1,2.5C14.2,19.1,15,19.5,16,19.5z M16,36c4.4-4,7.7-7.7,9.8-11s3.2-6.2,3.2-8.7c0-3.9-1.3-7.1-3.8-9.6S19.6,3,16,3
            S9.3,4.2,6.8,6.7S3,12.4,3,16.4c0,2.5,1.1,5.4,3.2,8.7S11.7,32,16,36z M16,40c-5.4-4.6-9.4-8.8-12-12.7s-4-7.5-4-10.9
            c0-5,1.6-9,4.8-11.9S11.8,0,16,0s8,1.5,11.2,4.4S32,11.4,32,16.4c0,3.3-1.3,7-4,10.9S21.4,35.4,16,40z"/>
        </symbol>

        <symbol id="icon-stars" x="0px" y="0px"
	            viewBox="0 0 3000 504.4" style="enable-background:new 0 0 3000 504.4;">
            <style>
                #icon-stars polygon {
                    fill: currentColor;
                }
            </style>
            <g>
	            <polygon points="265.2,401.5 101.3,504.4 148.5,316.8 0,192.7 193.1,179.6 265.2,0 337.3,179.6 530.4,192.7 
		            381.9,316.8 429.1,504.4"/>
	            <polygon points="882.6,401.5 718.7,504.4 765.9,316.8 617.4,192.7 810.5,179.6 882.6,0 954.7,179.6 1147.8,192.7 
		            999.3,316.8 1046.5,504.4"/>
	            <polygon points="1500,401.5 1336.1,504.4 1383.3,316.8 1234.8,192.7 1427.9,179.6 1500,0 1572.1,179.6 1765.2,192.7 
		            1616.7,316.8 1663.9,504.4"/>
	            <polygon points="2117.4,401.5 1953.5,504.4 2000.7,316.8 1852.2,192.7 2045.3,179.6 2117.4,0 2189.5,179.6 
		            2382.6,192.7 2234.1,316.8 2281.3,504.4"/>
	            <polygon points="2734.8,401.5 2570.9,504.4 2618.1,316.8 2469.6,192.7 2662.7,179.6 2734.8,0 2806.9,179.6 3000,192.7 
		            2851.5,316.8 2898.7,504.4"/>
            </g>
        </symbol>

        <symbol id="icon-search" x="0px" y="0px" viewBox="0 0 36 36" style="enable-background:new 0 0 36 36;">
            <style>
                #icon-search path {
                    fill: currentColor;
                    stroke: none;
                }
            </style>
            <path d="M33.8,36L20.6,22.8c-1,0.9-2.2,1.5-3.5,2c-1.3,0.5-2.8,0.7-4.2,0.7c-3.6,0-6.6-1.2-9.1-3.8S0,16.3,0,12.8s1.2-6.6,3.8-9.1
            S9.3,0,12.9,0c3.5,0,6.5,1.2,9,3.8s3.7,5.5,3.7,9.1c0,1.4-0.2,2.8-0.7,4.2c-0.5,1.3-1.2,2.6-2.1,3.8L36,33.8L33.8,36z M12.8,22.6
            c2.7,0,5-1,6.9-2.9c1.9-1.9,2.9-4.2,2.9-6.9s-1-5-2.9-6.9S15.6,3,12.9,3c-2.7,0-5.1,1-7,2.9S3,10.1,3,12.8s1,5,2.9,6.9
            S10.1,22.6,12.8,22.6z"/>
        </symbol>

        <symbol id="icon-instagram" x="0px" y="0px" viewBox="0 0 67.2 67.2">
            <path d="M47.5,15.9c0,2.2,1.8,3.9,3.9,3.9c2.2,0,3.9-1.8,3.9-3.9c0-2.2-1.8-3.9-3.9-3.9C49.2,12,47.5,13.8,47.5,15.9"/>
            <path d="M23.3,33.6C23.3,27.8,28,23,33.9,23c5.8,0,10.6,4.8,10.6,10.6c0,5.8-4.8,10.6-10.6,10.6C28,44.2,23.3,39.5,23.3,33.6
                    M17.3,33.6c0,9.1,7.4,16.6,16.6,16.6s16.6-7.4,16.6-16.6c0-9.1-7.4-16.6-16.6-16.6S17.3,24.5,17.3,33.6"/>
            <path d="M6.3,47V20.2c0-7.6,6.2-13.9,13.9-13.9H47c7.6,0,13.9,6.2,13.9,13.9V47c0,7.6-6.2,13.9-13.9,13.9H20.2
                C12.5,60.9,6.3,54.7,6.3,47 M20.2,0C9.1,0,0,9.1,0,20.2V47c0,11.1,9.1,20.2,20.2,20.2H47c11.1,0,20.2-9.1,20.2-20.2V20.2
                C67.2,9.1,58.2,0,47,0H20.2z"/>
        </symbol>

        <symbol id="icon-facebook" x="0px" y="0px" viewBox="0 0 36 67.2">
            <path d="M10.7,16.4v9.3H0v12.2h10.7v29.4h13.2V37.8h9.8l1.9-12.2H23.8v-7.9c0-3.3,1.6-6.6,6.9-6.6H36V0.8c0,0-4.8-0.8-9.4-0.8
            C17,0,10.7,5.8,10.7,16.4"/>
        </symbol>

        <symbol id="icon-youtube" x="0px" y="0px" viewBox="0 0 68.3 47.8">
            <path d="M25.6,32.9V15.4c0-0.8,2.3-1.3,3-0.9l16.5,9c0.7,0.4,1.4,1.4,0.7,1.8l-17.2,8.5c-0.2,0.1-0.4,0.1-0.7,0.1
            C27,33.9,25.6,33.5,25.6,32.9 M15,0C6.7,0,0,6.7,0,15v17.8c0,8.3,6.7,15,15,15h38.3c8.3,0,15-6.7,15-15V15c0-8.3-6.7-15-15-15H15z"
            />
        </symbol>

        <symbol id="icon-tiktok" x="0px" y="0px" viewBox="0 0 58.6 68.5">
            <path d="M32,0l-0.1,47.8c0,5.9-5.2,10.5-11,10.5c-5.9,0-10.6-4.8-10.6-10.6c0-5.9,4.8-10.6,10.6-10.6c0.4,0,0.9,0.1,1.3,0.1V26.9
            c-0.4,0-0.9-0.1-1.3-0.1C9.3,26.9,0,36.2,0,47.7c0,11.5,9.3,20.8,20.8,20.8c11.5,0,20.8-9.3,20.8-20.8V19.5
            c3.4,5.2,9.1,8.3,15.3,8.3c0.6,0,1.1,0,1.7-0.1h0V16.3C49.8,15.7,42.7,8.8,41.8,0H32z"/>
        </symbol>

        <symbol id="icon-cart" viewBox="0 0 72 62">
            <g>
                <path d="M39,55a7,7,0,1,0,7-7,7,7,0,0,0-7,7m4,0a3,3,0,1,1,3,3,3,3,0,0,1-3-3"></path>
                <path d="M7,55a7,7,0,1,0,7-7,7,7,0,0,0-7,7m4,0a3,3,0,1,1,3,3,3,3,0,0,1-3-3"></path>
                <path d="M14,52H46a2,2,0,0,0,1.9-1.37L63.44,4H70a2,2,0,0,0,0-4H62a2,2,0,0,0-1.9,1.37L44.56,48H14a2,2,0,0,0,0,4"></path>
                <path d="M10,40H50a2,2,0,1,0,0-4H11.44L4.77,16H58a2,2,0,1,0,0-4H2A2,2,0,0,0,.1,14.63l8,24A2,2,0,0,0,10,40"></path><path d="M6,28H54a2,2,0,1,0,0-4H6a2,2,0,0,0,0,4"></path>
                <path d="M37.5,40a2,2,0,0,0,2-1.75l3-24a2,2,0,0,0-4-.5l-3,24A2,2,0,0,0,37.25,40l.25,0"></path>
                <path d="M22.5,40l.25,0a2,2,0,0,0,1.74-2.23l-3-24a2,2,0,0,0-4,.5l3,24a2,2,0,0,0,2,1.75"></path>
            </g>
        </symbol>

        <symbol id="icon-checkmark" viewBox="0 0 101 77">
            <path d="M98.2871,3.4561c-4.96-4.96-13.51-4.53-19,.96L36.6071,47.0961l-14.15-14.15c-5.49-5.49-14.04-5.92-19-.96-4.96,4.96-4.53,13.51,.95,19l21.67,21.67c2.84,2.83,6.49,4.31,10.04,4.4h.98c3.55-.09,7.2-1.57,10.03-4.4L97.3271,22.4561c5.49-5.49,5.92-14.04,.95-19h.01Z"/>
        </symbol>
    </svg>
</span>

<%
    NavigationItem checkout = sitemap.GetItemById("cart");
    NavigationItem account = sitemap.GetItemById("create-account");
    NavigationItem login = sitemap.GetItemById("login");
%>
<template data-modal-dialog-template data-customer-cart-container-id="customer-cart">
    <div id="customer-cart" data-modal-dialog-title="Your Cart" data-modal-dialog-container>
        <section aria-labelledby="customer-cart-title" class="customer-cart customer-cart--has-items-in-cart">
            <div class="customer-cart__header">
                <h2 id="customer-cart-title" class="customer-cart__title">Your Cart</h2>
                <% if (FMLSHOP.Rules.Expose.Login) { %>
                <% if (Model.CurrentCustomer == null || Model.CurrentCustomer.StoreCustomerID == Guid.Empty) { %>
                <p class="customer-cart__actions">Have an Account? <a href="<%= login.Page %>">Log in</a> or <a href="<%= account.Page %>">create an account</a></p>
                <%  } %>
                <% } %>
                
                <% 
                    FathersDayOffer fathersDay = new FathersDayOffer();
                    
                    if (fathersDay.IsActive)
                    {
                        %>
                        <div class="customer-cart__offer">
                            <b class="customer-cart__banner banner banner--ribbon">
                                <span>Limited Time Offer</span>
                            </b>
                            <div class="customer-cart__desc">
                                <b>Buy 2 Get ONE FREE!</b>
                                <span>Hurry while offer lasts</span>
                            </div>
                        </div>
                        <%
                    }
                %>
            </div>
            <div class="customer-cart__cart" data-customer-cart-item-list></div>
            <div class="customer-cart__footer">
                <a href="<%= checkout.Page %>" class="button" data-modal-dialog-id="customer-cart" data-modal-dialog-actor="close">
                    <span>Proceed to Checkout</span>
                    <span class="customer-cart__order-total" data-order-total="{{totalC}}">{{totalC}}</span>
                </a>
                <button type="button" data-modal-dialog-id="customer-cart" data-modal-dialog-actor="close" class="button">
                    <span>Continue Shopping</span>
                </button>
            </div>
        </section>

        <section aria-labelledby="customer-cart-empty-title" class="customer-cart customer-cart--has-an-empty-cart">
            <div class="customer-cart__header">
                <h2 id="customer-cart-empty-title" class="customer-cart__title">Your Cart is Empty</h2>
                <% if (FMLSHOP.Rules.Expose.Login) { %>
                <% if (Model.CurrentCustomer == null || Model.CurrentCustomer.StoreCustomerID == Guid.Empty) { %>
                <p class="customer-cart__actions">Have an Account? <a href="<%= login.Page %>">Log in</a> or <a href="<%= account.Page %>">create an account</a></p>
                <% } %>
                <% } %>
                <h3 class="customer-cart__headline">Shop Flip My Life Products</h3>
            </div>
            <div class="customer-cart__cart">
                <div class="slide slide--category-products-customer-cart">
                    <div class="slide__into" tabindex="0" id="slide-category-products-customer-cart">
                    <%
                        List<string> productCodes = new List<string> { "F7V", "F7C", "CPB", "SML" };
                        List<CategoryProductRouter> categoryProducts = productCodes.Select(pc => categoryProductRouterEngine.GetCategoryProductByProductCode(pc)).Where(cp => categoryProductRouterEngine.IsValidCategoryProductRouter(cp)).ToList();
                
                        foreach (var categoryProduct in categoryProducts)
                        {
                            var categoryProductIndex = categoryProducts.IndexOf(categoryProduct);

                            %>
                            <div class="slide__item">
                            <%

                            Html.RenderPartial("CategoryProduct", new ViewDataDictionary
                            {
                                { "CategoryProductRouterEngine", categoryProductRouterEngine },
                                { "CategoryProduct", categoryProduct },
                                { "IsPdpPage", "true" },
                                { "Index", categoryProductIndex },
                                { "RenderVariantProductRadioGroup", false },
                                { "Id", "slide-category-products-customer-cart" }
                            });
                            %>
                            </div>
                            <%
                        }
                    %>
                    </div>
                    <div class="slide__nav">
                        <button aria-label="Previous" class="slide__prev" type="button">
                            <svg class="icon">
                                <use href="#icon-double-chevron"></use>
                            </svg>
                        </button>
                        <button aria-label="Next" class="slide__next" type="button">
                            <svg class="icon">
                                <use href="#icon-double-chevron"></use>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<template data-customer-cart-item-id="customer-cart">
    <div class="customer-cart__product" data-customer-cart-exclude-cart-count="{{props.ExcludeFromCartCount}}">
        <p class="customer-cart__product-name">{{name}}</p>
        <div class="customer-cart__product-picture" data-customer-cart-item-picture></div>
        <div class="customer-cart__product-actions">
            <div class="customer-cart__combobox" data-customer-cart-readonly="{{props.NoEdit}}">
                <div class="form form--icon-field-combobox form--label-combobox">
                    <div class="form__contain">
                        <button type="button" aria-label="Remove 1 of {{name}} from your cart" class="form__field form__button" data-shopping-cart-quantity-modifier="minus" aria-controls="{{code}}Qty_cart" data-shopping-cart-action="update" data-shopping-cart-product-code="{{code}}">
                            <svg class="icon">
                                <use href="#icon-minus"></use>
                            </svg>
                        </button>
                        <input min="0" max="{{max}}" class="form__field form__input" type="number" value="{{qty}}" aria-label="Current quantity" id="{{code}}Qty_cart" data-shopping-cart-sync="true" data-shopping-cart-product-code="{{code}}" data-shopping-cart-action="update" pattern="[{{min}}-{{max}}]" title="Up to {{max}} are allowed">
                        <button type="button" aria-label="Add 1 of {{name}} to your cart" class="form__field form__button" data-shopping-cart-quantity-modifier="plus" aria-controls="{{code}}Qty_cart" data-shopping-cart-action="update" data-shopping-cart-product-code="{{code}}">
                            <svg class="icon">
                                <use href="#icon-plus"></use>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>                
            <div class="customer-cart__quantity" data-customer-cart-readonly="{{props.NoEdit}}">
                <p>Quantity: {{qty}}</p>
            </div>
            <button type="button" class="customer-cart__button customer-cart__link" data-shopping-cart-action="remove" data-shopping-cart-product-code="{{code}}" data-customer-cart-readonly="{{props.NoEdit}}">Remove</button>
            <p class="customer-cart__price">{{priceC}}</p>
        </div>
    </div>
</template>