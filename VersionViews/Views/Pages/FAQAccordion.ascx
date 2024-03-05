<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Models" %>
<%@ Import Namespace="FMLSHOP.Text" %>

<%
    string productName = SettingsManager.ContextSettings["Label.ProductName"];
    string customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];

    Func<string, string> renderText = ((string text) =>
    {
        return text
            .Replace("{{ProductName}}", productName)
            .Replace("{{CustomerServiceEmail}}", string.Format(@"<a href=""mailto:{0}"">{0}</a>", customerServiceEmail));
    });

    List<FAQ> faqs = ProductFAQ.General;
        
    if (faqs.Count > 0) { %>
    <div id="faq-accordion" class="accordion accordion--block-format" data-accordion-toggle data-accordion-many-containers itemscope itemtype="https://schema.org/FAQPage">
        <% foreach (FAQ faq in faqs) { 
            int index = faqs.IndexOf(faq);      
        %>     
        <div class="card" itemscope itemprop="mainEntity" itemtype="https://schema.org/Question">
            <div class="accordion__header card__header" itemprop="name">
                <button type="button" class="accordion__button card__button" aria-controls="faq-section-<%= index %>" id="faq-controller-<%= index %>" aria-expanded="false">
                    <span><%= renderText(faq.Question) %></span>
                    <span class="accordion__icon"></span>
                </button>
            </div>
            <section hidden aria-labelledby="faq-controller-<%= index %>" id="faq-section-<%= index %>" class="card__section accordion__section" itemscope itemprop="acceptedAnswer" itemtype="https://schema.org/Answer">
                <div class="card__content" itemprop="text">
                    <%= renderText(faq.Answer) %>		
                </div>
            </section>
        </div>
        <% } %>
    </div>
<% } %>