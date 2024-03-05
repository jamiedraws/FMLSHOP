<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/Site1/index.css" rel="preload" as="style" />
    <link href="/css/Site1/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
    NavigationItem index = sitemap.GetItemById("index");
    var csRetailPhoneNumber = SettingsManager.ContextSettings["CustomerService.Retail.PhoneNumber--Retail--", "800-801-1522"]; 
%>

<main aria-labelledby="main-title" class="view content content--cs content--sub-page section">
    <div id="main" class="view__anchor"></div>
    <div class="content__text">
        <div class="content__header">
            <h1 id="main-title" class="content__title">Contact Us</h1>
        </div>
        <div class="view__in section__in element-controller">
            <div class="customer-service__copy">
                <h2>We'd love to hear from you!</h2>
                <p>So that we may best direct you to the appropriate beauty advisor, please select where you purchased your Finishing Touch Flawless product:</p>
            </div>
            <div class="customer-service customer-service--contact-nav">
                <nav aria-label="Customer Support Links" class="customer-service__nav">
                    <a href="javascript:void(0);" aria-controls="cs-online-container" class="customer-service__link button" id="online-support">
                        <span>Online Purchase</span>
                        <small>(flawlessbeauty.com)</small>
                    </a>
                    <a href="javascript:void(0);" aria-controls="cs-retail-container" class="customer-service__link button" id="retail-support">
                        <span>Retailer Purchase</span>
                        <small>(online or in-store)</small>
                    </a>
                </nav>
            </div>

            <template data-modal-dialog-template>
                <section class="customer-service customer-service--descriptor-iframe" id="customer-service-descriptor" data-modal-dialog-title="Customer Service Form" data-modal-dialog-container>
                    <div class="customer-service__descriptor customer-service customer-service--logo-title-address">
                        <div class="customer-service__group">
                            <!-- <button type="button" class="customer-service__go-back" data-modal-dialog-actor="close" data-modal-dialog-id="customer-service-descriptor" aria-label="Close dialog" data-modal-dialog-parent-id="customer-service-descriptor">
                                <svg class="icon">
                                    <use href="#icon-chevron"></use>
                                </svg>
                                Go Back
                            </button> -->
                            <picture class="customer-service__logo">
                                <img src="/images/Site1/logo.svg" alt="Finishing Touch Flawless" />
                            </picture>
                            <span class="customer-service__divider"></span>
                            <span class="customer-service__title">Contact Us</span>
                            <address class="customer-service__address">
                                <p>Your questions and comments are important to us! You can contact FINISHING TOUCH FLAWLESS via phone or text (M-F 8:00AM - 5:00PM ET) at <a href="tel:<%= csRetailPhoneNumber %>" style="text-decoration: none; outline: none;"><%= csRetailPhoneNumber %></a>.</p>
                                <p>For response via email, please complete the form below to submit a question or comment and provide us with as much information as possible. Please allow 24-48 hours to receive a response Monday &ndash; Friday.</p>
                            </address>
                        </div>
                    </div>
                    <iframe class="customer-service__iframe" loading="lazy" src="https://www.econsumeraffairs.com/ChurchDwight/multi/contactus.htm?F1=FLAW" frameborder="0"></iframe>
                </section>
            </template>

            <div class="view customer-service customer-service--online-info customer-service--close element-controller__element" id="cs-online-container">
                <div id="cs-online" class="view__anchor"></div>
                <div class="customer-service__in customer-service__text">
                    <%
                        string csPhoneNumber = SettingsManager.ContextSettings["CustomerService.PhoneNumber"];    
                    %>
                        
                    <div class="customer-service__group">
                        <div class="customer-service__item">
                            <svg class="icon customer-service__icon">
                                <use href="#mail"></use>
                            </svg>
                            <span>email us 24/7</span>
                            <a href="mailto:flawless@customerstatus.com" id="cs-online-email-link">flawless@customerstatus.com</a>
                            <small>(please allow 24-48 hr response time)</small>
                        </div>
                        <div class="customer-service__item">
                            <svg class="icon customer-service__icon">
                                <use href="#phone"></use>
                            </svg>
                            <span>call us</span>
                            <a href="tel:<%= csPhoneNumber %>" id="cs-online-call-link"><%= csPhoneNumber %></a>
                            <small>8am-8pm EST Monday-Friday</small>
                        </div>
                        <div class="customer-service__item">
                            <svg class="icon customer-service__icon">
                                <use href="#icon-cart"></use>
                            </svg>
                            <span>check order status</span>
                            <a href="https://customerstatus.com/SearchUpdate.aspx" target="_blank" id="cs-online-tracking">track now</a>
                        </div>
                        <div class="customer-service__item customer-service__item--social">
                            <svg class="icon customer-service__icon">
                                <use href="#heart"></use>
                            </svg>
                            <span>follow us</span>
                            <div class="customer-service__social">
                                <%
                                List<NavigationItem> socialItems = sitemap.GetItemsByIdRange(new List<string>
                                {
                                    "instagram",
                                    "facebook",
                                    "youtube",
                                    "tiktok"
                                });

                                if (socialItems.Any())
                                {
                                    %>
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
                    </div>
                        
                </div>
            </div>

            <div class="view customer-service customer-service--online-info customer-service--close element-controller__element" id="cs-retail-container">
                <div id="cs-retail" class="view__anchor"></div>
                <div class="customer-service__in customer-service__text">
                    <div class="customer-service__group">
                        <div class="customer-service__item">
                            <svg class="icon customer-service__icon">
                                <use href="#mail"></use>
                            </svg>
                            <a data-modal-dialog-actor="open" data-modal-dialog-id="customer-service-descriptor" data-modal-dialog-title="Customer Service Form" data-modal-dialog-template-modifier="contact-form" href="https://www.econsumeraffairs.com/ChurchDwight/multi/contactus.htm?F1=FLAW" target="_blank" aria-haspopup="true" id="retail-support">
                                email us 24/7
                            </a>
                            <small>(please allow 24-48 hr response time)</small>
                        </div>
                        <div class="customer-service__item">
                            <svg class="icon customer-service__icon">
                                <use href="#phone"></use>
                            </svg>
                            <span>call or text us</span>
                            <a href="tel:800-801-1522" id="cs-retail-call-link">800-801-1522</a>
                            <small>8am-5pm EST Monday-Friday</small>
                        </div>
                        <div class="customer-service__item customer-service__item--social">
                            <svg class="icon customer-service__icon">
                                <use href="#heart"></use>
                            </svg>
                            <span>follow us</span>
                            <div class="customer-service__social">
                                <%
                                List<NavigationItem> socialItems2 = sitemap.GetItemsByIdRange(new List<string>
                                {
                                    "instagram",
                                    "facebook",
                                    "youtube",
                                    "tiktok"
                                });

                                if (socialItems2.Any())
                                {
                                    %>
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
                    </div>
                        
                </div>
            </div>

        </div>            
    </div>
</main>

</asp:Content>