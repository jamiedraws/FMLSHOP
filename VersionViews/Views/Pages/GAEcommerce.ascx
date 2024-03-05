<%--Wiki url: https://digitaltargetmarketing.atlassian.net/wiki/display/DEV/Google+Analytics+Ecommerce--%>

<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<!-- gaecommerce uc -->
<%

    string orderCodeKey = "gaEcommerce" + ViewData["ControlId"].ToString();
    var fireOnTest = bool.Parse((ViewData["FireOnTest"] as string) ?? "false");
    var isTest = DtmContext.IsTestSession || (DtmContext.Order != null && DtmContext.Order.IsTestOrder);
    bool isRefireAllowed = bool.Parse((ViewData["RefireAllowed"] as string) ?? "false");


    var accountId = (ViewData["AccountId"] as string) ?? string.Empty;
    var accountName = accountId.Replace("-", "X");
    var paymentType = (!string.IsNullOrEmpty(DtmContext.Order.Codes["PaymentType"].Code ?? string.Empty) ? DtmContext.Order.Codes["PaymentType"].Code
        : !string.IsNullOrWhiteSpace(DtmContext.Order.CardType) ? DtmContext.Order.CardType : "None").ToUpper();

    var hasFiredSale = DtmContext.FiredConversionCodes.Any(p => p.Equals("GAEcommerce_" + accountId, StringComparison.InvariantCultureIgnoreCase));

%>
    <script type="text/javascript">
        var ecommerceTrackerId = '<%= ViewData["AccountId"] %>';
        if (typeof ga === 'undefined') {
            // GA hasn't been loaded yet, so load it here
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date(); a = s.createElement(o),
                    m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
            })(window, document, 'script', 'https://www.google-analytics.com/analytics.js', 'ga');
            ga('create', ecommerceTrackerId, 'auto', { 'name': '<%=accountName%>' });
        };
        ga('<%=accountName%>.require', 'ec');

    </script>

<%  if (DtmContext.Page.IsStartPageType)
    {  %>
<script>

    registerEvent("CartChange", function () {
        if (typeof ga !== 'undefined') {
            ga('<%=accountName%>.send', 'event', 'Cart', 'Product Quantity Added');
        }
    });
</script>


<%} %>
<%

    // If the order is complete, it can't be changed anymore, we should send a "purchase" event to GA Ecommerce
    bool isOrderComplete = Dtm.Framework.Base.Configuration.FrameworkCommon.OrderStatusHelper.IsComplete(DtmContext.Order.OrderStatusId);
    var magentoOrderId = DtmContext.Order.Codes["MagentoOrderId"].Code ?? DtmContext.OrderId.ToString();

    if (isOrderComplete && !hasFiredSale)
    {        
        DtmContext.FiredConversionCodes.Add("GAEcommerce_" + accountId);
%>
    <script type="text/javascript">

        <% // send product detail view %>
        var sent = [];
        $('[name^="ActionCode"').each(function () {
            var pcode = $(this).val();
            if (sent.indexOf(pcode) > -1) return;

            sent.push(pcode);
            ga('<%=accountName%>.ec:addProduct', {
                'id': pcode,
                'name': pcode
            });
            ga('<%=accountName%>.ec:setAction', 'detail');
            ga('<%=accountName%>.send', 'event', 'Cart', 'Product View');
        });
<%
        foreach (var item in DtmContext.Order.OrderItems)
        {
%>
        ga('<%=accountName%>.ec:addProduct', {
            'id': '<%= item.CampaignProduct.ProductCode %>',
                'name': '<%= item.ProductSku %>',
                'category': '<%= item.CampaignProduct.ProductType %>',
                'price': '<%= item.Price %>',
                'quantity': '<%= item.Quantity %>'
            });
<%
        }
%>
        ga('<%=accountName%>.ec:setAction', 'checkout', {
            'option': '<%= paymentType %>'
        });

        ga('<%=accountName%>.send', 'event', 'checkout', 'option', {});

        <%
        foreach (var item in DtmContext.Order.OrderItems)
        {
%>
        ga('<%=accountName%>.ec:addProduct', {
            'id': '<%= item.CampaignProduct.ProductCode %>',
                'name': '<%= item.ProductSku %>',
                'category': '<%= item.CampaignProduct.ProductType %>',
                'price': '<%= item.Price %>',
                'quantity': '<%= item.Quantity %>'
            });
<%
        }
%>
        ga('<%=accountName%>.ec:setAction', 'purchase', {
            'id': '<%= magentoOrderId %>',
            'affiliation': '<%= ViewData["StoreName"] %>',
            'revenue': '<%= DtmContext.Order.OrderTotal %>',
            'tax': '<%= DtmContext.Order.TotalTax %>',
            'shipping': '<%= DtmContext.Order.ShippingCost %>',
            'option': '<%= DtmContext.PageCode %>'
        });
        ga('<%=accountName%>.send', 'event', 'Cart', 'Confirmation');
    </script>
<%
        return;
    }
    
    // Check if we've previously saved the order to the database
    var context = Dtm.Framework.Models.Ecommerce.Repositories.EcommerceDataContextManager.Current;
    var orderCode = context.ExecuteQuery<string>(string.Format("SELECT Code FROM OrderCodes (NOLOCK) WHERE OrderId = {0} AND Label = '{1}'", DtmContext.Order.OrderID, orderCodeKey))
        .DefaultIfEmpty()
        .First();

    dynamic dbOrder = null;
    if (orderCode != null)
    {
        dbOrder = new System.Web.Script.Serialization.JavaScriptSerializer().Deserialize<dynamic>(orderCode);
    }

    // Now that we've checked for a Db order, save the current order so we can check next time
    var objectItems = new List<object>();
    foreach (var item in DtmContext.Order.OrderItems)
    {
        objectItems.Add(new { item.OrderItemId, item.CachedProductInfo.ProductSku, item.Price, item.Quantity, item.CampaignProductId, item.CampaignProduct.ProductCode, item.CampaignProduct.ProductType });
    }    
    dynamic currentOrder = new { DtmContext.Order.OrderID, DtmContext.Order.OrderTotal, DtmContext.Order.TotalTax, DtmContext.Order.ShippingCost, Items = objectItems };
    if (currentOrder.OrderTotal > 0)
    {
        orderCode = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(currentOrder);
        var sql = string.Format("exec DtmInternational.dbo.FW_AddOrUpdateOrderCode {0}, '{1}', '{2}'", DtmContext.Order.OrderID, orderCodeKey, orderCode);
        context.ExecuteCommand(sql, new object[0]);
    }

    // Check for changes in the order. If nothing changed in the order, then return
    if (dbOrder != null)
    {
        bool hasChanges = currentOrder.OrderTotal != dbOrder["OrderTotal"];
        hasChanges = hasChanges || currentOrder.Items.Count != dbOrder["Items"].Length;
        foreach (var dbItem in dbOrder["Items"])
        {
            foreach (var currentItem in currentOrder.Items)
            {
                if (currentItem.CampaignProductId.ToString() == dbItem["CampaignProductId"])
                {
                    hasChanges = hasChanges || currentItem.Quantity != dbItem["Quantity"];
                }
            }
        }
        if (hasChanges == false)
        {
            // no changes
            return;
        }
    }
    
%>
    <script type="text/javascript">
        var id = null, name = null, category = null, price = null, quantity = null;
<%
    if (dbOrder != null)
    {            
        // Refund the original order so it can be added again
%>
        ga('<%=accountName%>.ec:setAction', 'refund', {
            'id': '<%= magentoOrderId %>'    // Transaction ID is only required field for full refund.
        });
        ga('<%=accountName%>.send', 'event', 'Cart', 'Refund');
<%
 
        // Find differences in item Qty and either add or remove the difference
        foreach (var dbItem in dbOrder["Items"])
        {
            var quantity = (int)dbItem["Quantity"];
            var containsItem = false;
%>
            < !--diff -->
            id = '<%= dbItem["ProductSku"] %>';
        name = '<%= (dbItem["ProductSku"] ?? string.Empty ).Replace("'", "\\'") %>';
        category = '<%= (dbItem["ProductSku"] ?? string.Empty ).Replace("'", "\\'") %>';
            price = '<%= dbItem["Price"] %>';
            quantity = '<%= quantity %>';
<%

            // Check if there is already an item and if it has changed.
            foreach (var currentItem in currentOrder.Items)
            {
                if (currentItem.CampaignProductId.ToString() == dbItem["CampaignProductId"])
                {
                    containsItem = true;
                    if (currentItem.Quantity != (int)dbItem["Quantity"])
                    {
                        quantity = (int)currentItem.Quantity - (int)dbItem["Quantity"];
                        //add the difference
%>
                        quantity = '<%= quantity %>';

                        <!-- ai1 -->
                        ga('<%=accountName%>.ec:addProduct', {
                            'id': id,
                            'name': name,
                            'category': category,
                            'price': price,
                            'quantity': Math.abs(quantity)
                        });
                        if (quantity > 0) {
                            ga('<%=accountName%>.ec:setAction', 'add', { option: '<%= DtmContext.PageCode %>' });
                            ga('<%=accountName%>.send', 'event', 'Cart', 'Product Quantity Added');
                        } else {
                            ga('<%=accountName%>.ec:setAction', 'remove', { option: '<%= DtmContext.PageCode %>' });
                            ga('<%=accountName%>.send', 'event', 'Cart', 'Product Quantity Removed');
                        }
<%
                    }
                    break;
                }
            }   // currentItem loop
            // No item found this item is old and has been removed
            if (!containsItem)
            {
%>
                <!-- ai2 -->
                ga('<%=accountName%>.ec:addProduct', {
                    'id': id,
                    'name': name,
                    'category': category,
                    'price': price,
                    'quantity': quantity
                });
                ga('<%=accountName%>.ec:setAction', 'remove', { option: '<%= DtmContext.PageCode %>' });
                ga('<%=accountName%>.send', 'event', 'Cart', 'Product Removed');
<%
            }
        }   // dbItem loop
    }   // if (dbOrder != null)

    // Check new items that havent been added
    foreach (var item in currentOrder.Items)
    {
        bool itemFound = false;
        if (dbOrder != null)
        {
            foreach (var oi in dbOrder["Items"])
            {
                if (oi["CampaignProductId"] == item.CampaignProductId.ToString())
                {
                    itemFound = true;
                    break;
                }
            }
        }
        if (itemFound)
        {
            continue;
        }

%>
        <!-- ai3 -->
        id = '<%= item.ProductCode %>';
        name = '<%= (item.ProductSku ?? string.Empty ).Replace("'", "\\'") %>';
        category = '<%= item.ProductType %>';
        price = '<%= item.Price %>';
        quantity = '<%= item.Quantity %>';
        ga('<%=accountName%>.ec:addProduct', {
            'id': id,
            'name': name,
            'category': category,
            'price': price,
            'quantity': quantity
        });
        <%
    }   // currentOrder items loop
        // Done adding the products, send a checkout event since user hasn't gotten to payment screen

    // Determine if this order has been paid (at least the main product)
    bool isPaid = context.PaymentTransactions.Any(x =>
        x.OrderID == DtmContext.OrderId
        && (
            x.ResponseCode == "Approved"
            || x.ResultCode.Contains("APPROVED")
            || x.ResultCode.Contains("00")
        )
    );

    if (isPaid)
    {
%>      ga('<%=accountName%>.ec:setAction', 'checkout', {
            'option': '<%= paymentType %>'
        });

        ga('<%=accountName%>.send', 'event', 'checkout', 'option', {});

 <%   foreach (var item in currentOrder.Items)
    {
        bool itemFound = false;
        if (dbOrder != null)
        {
            foreach (var oi in dbOrder["Items"])
            {
                if (oi["CampaignProductId"] == item.CampaignProductId.ToString())
                {
                    itemFound = true;
                    break;
                }
            }
        }
        if (itemFound)
        {
            continue;
        }

%>
        <!-- ai3 -->
        id = '<%= item.ProductCode %>';
        name = '<%= (item.ProductSku ?? string.Empty ).Replace("'", "\\'") %>';
        category = '<%= item.ProductType %>';
        price = '<%= item.Price %>';
        quantity = '<%= item.Quantity %>';
        ga('<%=accountName%>.ec:addProduct', {
            'id': id,
            'name': name,
            'category': category,
            'price': price,
            'quantity': quantity
        });
        <%
    }%>

        ga('<%=accountName%>.ec:setAction', 'purchase', {
            'id': '<%= magentoOrderId %>',
            'affiliation': '<%= ViewData["StoreName"] %>',
            'revenue': '<%= currentOrder.OrderTotal %>',
            'tax': '<%= currentOrder.TotalTax %>',
            'shipping': '<%= currentOrder.ShippingCost %>',
            'option': '<%= DtmContext.PageCode %>'
        });
<%
    }
    else
    {
%>
        ga('<%=accountName%>.ec:setAction', 'checkout', {
            'option': '<%= paymentType %>'
        });

        ga('<%=accountName%>.send', 'event', 'checkout', 'option', {});
<%
    }
%>
        ga('<%=accountName%>.send', 'event', 'Cart', 'Update');
    </script>
<!-- ./gaecommerce uc -->


<%
    /* Notes:
     * Documentation: https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce
     * The action determines what is happening in GA. You may call addProduct the same way but the action type determines how it's handled in Ga.
     * For example, you may call addProduct for a refund, a quantity change, or adding/removing a product from the cart.
     * 
     * In our case, 
     */
%>