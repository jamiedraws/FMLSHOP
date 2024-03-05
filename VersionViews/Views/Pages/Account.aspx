<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>


<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.Classes" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%
        NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;

        NavigationItem home = sitemap.GetItemById("home");

        var currentCustomer = Model.CurrentCustomer;

        if (currentCustomer == null)
        {
            Response.Redirect(home.Page);
        }
        else
        {
    %>

    <%-- 4. My Account --%>
    <main aria-labelledby="main-title" class="view store section">
        <div id="main" class="view__anchor"></div>
        <div class="view__in section__in">
            <div class="section__block">
                <h1 id="main-title" class="store__title">My Account</h1>
                <div class="store__contain store__space store__copy">

                    <h2 class="store__header">Exclusive Content</h2>
                    <p class="store__exclusive-callout">
                        <a href="/Profile/ExclusiveContent?cver=<%= DtmContext.VersionId %>">Click here for your FREE exclusive access</a> to mindset workshops, physical movement tips and workouts, and overall health tips and advice from our medical team. All this will be delivered to you through video and live seminars.
                    </p>

                    <% 
                        if (currentCustomer != null)
                        {
                    %>

                    <h2 class="store__header">Customer Address Book</h2>
                    <div class="store__group">
                        <%
                            var customerAddresses = ViewData["customerAddresses"] as List<StoreCustomerAddress> ?? Model.CurrentCustomer.StoreCustomerAddresses.ToList();
                            customerAddresses = customerAddresses.OrderByDescending(s => s.IsDefault.HasValue && s.IsDefault.Value).ToList();

                            if (customerAddresses.Any())
                            {
                                foreach (var customerAddress in customerAddresses)
                                {
                                    var address = customerAddress;

                                    var isDefault = address.IsDefault as bool? ?? false;
                                    var isShipping = address.IsShipping as bool? ?? false;

                                    var addressType = string.Format("{0} Address", isShipping ? "Shipping" : "Billing");
                                    var addressName = string.Format("{0} {1}", address.FirstName, address.LastName);
                        %>
                        <div class="address">
                            <div class="address__type">
                                <!--<span><%= addressType %></span>-->
                                <% if (isDefault)
                                    { %>
                                <span class="address__default"></span>
                                <svg role="presentation" aria-hidden="true" class="address__icon icon">
                                    <use href="#icon-checkmark"></use>
                                </svg>
                                <% } %>
                            </div>
                            <address class="address__details">
                                <div class="address__name"><%= addressName %></div>
                                <div class="address__address">
                                    <%=address.Street %><br>
                                    <%=!string.IsNullOrWhiteSpace(address.Street2) ? address.Street2 + "<br>" : string.Empty %>
                                    <%=address.City %>,&nbsp;<%=address.State %>&nbsp;<%=address.Zip %><br>
                                    <%=address.Country %>
                                </div>
                            </address>

                            <nav aria-label="Manage address for <%= addressName %>" class="address__nav">
                                <% if (!isDefault)
                                    { %>
                                <!-- program to change default address -->
                                <a href="javascript:void(0);" data-address-id="<%=address.StoreCustomerAddressID %>" data-isshipping="<%=address.IsShipping.ToString() %>" class="setDefault">Set As Default</a> | 
                            <% } %>
                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Profile?mode=editAddress&addressId=<%=address.StoreCustomerAddressID %>">Edit</a> | 
                                <a href="javascript:void(0);" data-addressid="<%=address.StoreCustomerAddressID %>" class="removeAddress">Remove</a>
                            </nav>
                        </div>
                        <%
                            }
                        %>
                        <nav aria-label="Add address" class="store__nav address__add">
                            <div class="store__group">
                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Profile?mode=addAddress" class="button ">Add new address</a>
                            </div>
                        </nav>
                        <%
                            }
                            else
                            {
                        %>
                        <span>There are no available addresses.</span>
                        <nav aria-label="Add address" class="store__nav address__add">
                            <div class="store__group">
                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Profile?mode=addAddress" class="button ">Add new address</a>
                            </div>
                        </nav>
                        <%
                            }
                        %>
                    </div>

                    <h2 class="store__header">Order History</h2>
                    <div id="myAccountContent" class="orderHistoryTable">
                        <% 
                            try
                            {
                                var customerOrders = Model.CustomerOrders.Where(c => c.CampaignOfferVersionID == DtmContext.VersionId
                                && (c.OrderStatusId == 3 || c.OrderStatusId == 2)).OrderByDescending(c => c.OrderDate).ToList();
                                if (customerOrders.Any())
                                {

                                    var categoryProductRouterEngine = new CategoryProductRouterEngine();
                        %>
                        <div
                            class="accordion"
                            data-accordion-toggle
                            data-accordion-many-containers>
                            <% foreach (var order in customerOrders)
                                { %>
                            <div class="card">
                                <div class="accordion__header card__header">
                                    <button class="accordion__button" aria-controls="ID-section-<%=order.OrderID.ToString() %>" id="ID-title-<%=order.OrderID.ToString() %>">
                                        <div class="order-item">
                                            <div class="order-item__group">
                                                <div class="order-item__item">
                                                    <span><%= order.OrderDate.ToString("MMMM dd, yyyy") %></span>
                                                    <span class="order-item__id"><%= order.Codes["MagentoOrderId"].Code ?? order.OrderID.ToString() %></span>
                                                </div>
                                                <div class="order-item__item">
                                                    <span><%= (order.OrderTotal + decimal.Parse(order.Codes["MagentoTaxAmount"].Code ?? "0.00")).ToString("C") %></span>
                                                </div>
                                            </div>
                                        </div>
                                    </button>
                                </div>
                                <section aria-labelledby="ID-title-<%=order.OrderID.ToString() %>" id="ID-section-<%=order.OrderID.ToString() %>" class="card__section accordion__section">
                                    <div class="card__content">
                                        <table class="order-table order-table--order-item">
                                            <% 
                                                foreach (var oi in order.OrderItems)
                                                {
                                                    var productInfo = oi.CachedProductInfo;
                                                    var image = new ProductImages(productInfo.ProductCode).GetFirstImagePath();
                                                    var route = categoryProductRouterEngine.GetCategoryProductByCampaignProductView(productInfo);
                                            %>
                                            <tr>
                                                <td data-eflex--category-label="Description">
                                                    <a href="<%= route.RouteToProductDetailPage %>" class="order-table__group">
                                                        <% if (!string.IsNullOrEmpty(image))
                                                            { %>
                                                        <picture class="order-table__picture">
                                                            <img src="<%= image %>" alt="<%= productInfo.ProductName %>" loading="lazy" width="100" height="100" />
                                                        </picture>
                                                        <% } %>
                                                        <span>
                                                            <%= oi.Description %>
                                                        </span>
                                                    </a>
                                                </td>
                                                <td data-eflex--category-label="Quantity">
                                                    <%= oi.Quantity %>
                                                </td>
                                                <td data-eflex--category-label="Price">
                                                    <%= oi.Price.ToString("C") %>
                                                </td>
                                                <td data-eflex--category-label="Shipping">
                                                    <%=oi.Shipping.ToString("C") %>
                                                </td>
                                                <td data-eflex--category-label="Total">
                                                    <%= ((oi.Price + oi.Shipping) * oi.Quantity).ToString("C") %>
                                                </td>
                                            </tr>
                                            <% 
                                                }
                                            %>
                                        </table>
                                    </div>
                                </section>
                            </div>
                            <% 
                                }
                            %>
                        </div>
                        <% }
                            else
                            { %>
                        <p>You haven't placed any orders yet.</p>
                        <%
                            } %>
                        <%
                            }
                            catch (Exception ex)
                            {
                                new SiteExceptionHandler(ex);
                        %>
                        <p>You haven't placed any orders yet.</p>
                        <% 
                            }
                        %>
                    </div>

                    <% }
                            else
                            {
                                var loginPageUrl = String.Format("/{0}/{1}/Account/Login", DtmContext.OfferCode, DtmContext.Version);
                                Response.Redirect(loginPageUrl);
                            }
                        } %>
                </div>
            </div>
        </div>
    </main>
    <script type="text/javascript">
        (function () {

            var removeAddressElement = document.getElementsByClassName("removeAddress");

            for (var i = 0; i < removeAddressElement.length; i++) {
                removeAddressElement[i].addEventListener("click", removeAddress);
            }

            function removeAddress() {
                var xhttp = new XMLHttpRequest();

                xhttp.onreadystatechange = function () {
                    if (this.readyState === 4) {
                        window.location = "/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index";
                    }
                }

                xhttp.open("POST", "/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Profile/RemoveAddress", true);

                xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

                xhttp.send("addressId=" + this.dataset.addressid);
            }

            var setDefaultElement = document.getElementsByClassName("setDefault");

            for (var i = 0; i < setDefaultElement.length; i++) {
                setDefaultElement[i].addEventListener("click", setDefaultAddress);
            }

            function setDefaultAddress() {
                var xhttp = new XMLHttpRequest();

                xhttp.onreadystatechange = function () {
                    if (this.readyState === 4) {
                        window.location = "/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index";
                    }
                }

                xhttp.open("POST", "/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Profile/SetDefault", true);
                xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                xhttp.send("addressId=" + this.dataset.addressId + "&isShipping=" + this.dataset.isshipping);
            }

        })();
    </script>
</asp:Content>
