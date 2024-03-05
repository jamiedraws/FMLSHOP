<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>

<!-- <script>
    function submitEmailLead() {
        var emailAddress = typeof $('#emailSubscribe') != "undefined" && $('#emailSubscribe').length > 0 ? $('#emailSubscribe').val() : null;
        var url = '/Cart/Subscribe/<%=DtmContext.PageCode%>?email=' + emailAddress;

        if (validateEmail(emailAddress)) {
            $('#emailSubscribeButton').prop('disabled', true);

            $.get(url, function (data) {
                $('#emailSubscribe').val('');
                window.cartToast.post("Successfully subscribed!");
                $("[data-validate-form-message]").html("For 10% off your order, checkout using <b>WELCOME10</b>");
                setTimeout(function () { window.cartToast.hide(); }, 3000);
                document.cookie = "lead=1; path=/";
            }).fail(function () {
                window.cartToast.post("Unable to process request at this time. Please try again.");
            }).always(function () {
                window.cartToast.show();
                setTimeout(function () { window.cartToast.hide(); }, 3000);
                $('#emailSubscribeButton').prop('disabled', false);
            });
        }
        else {
            window.cartToast.post("Email is invalid. Please try again.");
            window.cartToast.show();
            setTimeout(function () { window.cartToast.hide(); }, 3000);
        }
    }

    function validateEmail(email) {
        const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }
</script> -->
