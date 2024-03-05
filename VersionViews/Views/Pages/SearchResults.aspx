<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.Extensions" %>
<%@ Import Namespace="FMLSHOP.Classes" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preload" href="/css/Site1/product-listing-page.css" as="style" />
    <link rel="stylesheet" href="/css/Site1/product-listing-page.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    var query = Request["query"] as string ?? string.Empty;
    var show = Request["show"] as string ?? string.Empty;
    var products = Session["Products"] as List<CampaignProductView>;
    var productSearch = new ProductSearch(products);

    if (!productSearch.HasResults())
    {
        productSearch
            .GetSearchableProducts()
            .FilterByQuery(query, false)
            .FilterByProductType();

        products = productSearch.CampaignProducts;
        TempData["CriteoProducts"] = productSearch.CampaignProducts;
    }

    string productName = SettingsManager.ContextSettings["Label.ProductName"];
%>

<main aria-labelledby="search-results-title" class="view product-grid product-grid--search product-grid--listing section">
    <div id="search-results" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="product-grid__header">
            <h1 id="search-results-title" class="product-grid__title">Shop <%= productName %></h1>
            <%
                var resultsResponse = productSearch.HasResults() ? 
                    "Showing results for <i>{0}</i>" : "No search results found for <i>{0}</i>";
            %>
            <% if (show != "all") { %>
            <strong class="content__desc"><%= string.Format(resultsResponse, query) %></strong>
            <% } %>
        </div>
        <% if (productSearch.HasResults()) { %>
        <div class="section__block">
            <div class="product-grid__group">
                    <%
                        var categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

                        var productSearchResults = productSearch.CampaignProducts
                            .Distinct()
                            .ToList();

                        var categoryProducts = productSearchResults
                            .FilterProductsByLiveProperty()
                            .Select(cp => categoryProductRouterEngine.GetCategoryProductByCampaignProductView(cp))
                            .ToList();

                        categoryProducts = categoryProductRouterEngine.GetValidCategoryProductRouterCollection(categoryProducts).ToList();

                        foreach (var categoryProduct in categoryProducts)
                        {
                            var index = categoryProducts.IndexOf(categoryProduct);

                            Html.RenderPartial("CategoryProduct", new ViewDataDictionary
                            {
                                { "CategoryProductRouterEngine", categoryProductRouterEngine },
                                { "CategoryProduct", categoryProduct },
                                { "IsSearchPage", "true" },
                                { "Index", index },
                                { "Id", "slide-category-products" }
                            });
                        }
                    %>
                </div>
            </div>
        <% } %>
    </div>
</main>

</asp:Content>