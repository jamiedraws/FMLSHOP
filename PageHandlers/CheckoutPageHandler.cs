using Dtm.Framework.ClientSites.Web;
using FMLSHOP.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FMLSHOP.PageHandlers
{
    public class CheckoutPageHandler : PageHandler
    {
        public override void PostProcessPageActions()
        {
            var checkoutAccountEngine = new CheckoutAccount(Form);
            checkoutAccountEngine.Initialize();
        }
    }
}