<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OrderPageViewData>" %>
<h2 class="store__header">Customer Address Book</h2>
<div class="store__group">
<%
    var customerAddresses = ViewData["customerAddresses"] as List<StoreCustomerAddress> ?? Model.CurrentCustomer.StoreCustomerAddresses.ToList();
    customerAddresses = customerAddresses.OrderByDescending(s => s.IsDefault.HasValue && s.IsDefault.Value).ToList();

    if (customerAddresses.Any()) {
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
        <%-- <span><%= addressType %></span> --%>
        <% if (isDefault) { %>
           <b>Default Address</b>
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
        <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Profile?mode=editAddress&addressId=<%=address.StoreCustomerAddressID %>" class="button button--second button--contrast">Edit</a>
        <a href="javascript:void(0);" data-addressid="<%=address.StoreCustomerAddressID %>" class="button button--second button--contrast removeAddress">Remove</a>
    </nav>
</div>
<%
        }
    } 
    else
    {
        %>
        <span>There are no available addresses.</span>
        <%
    }
%>
</div>