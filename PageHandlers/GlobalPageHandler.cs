using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web.Mvc;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Models;
using Dtm.Framework.Models.Ecommerce;
using Dtm.Framework.Services.AddressVerification.UnitedStatesPostalService;
using Dtm.Framework.Services.DtmApi;
using FMLSHOP.PromoCodeHelper;
using FMLSHOP.LimitedTimeOffer;
using System.Web;

namespace FMLSHOP.PageHandlers
{
    public class GlobalPageHandler : PageHandler
    {

        private readonly string[] SubscriptionItems = { "CF7C", "CF7V", "CCPB", "CSML" };
        private readonly PromoCodeManager promoCodeManager = new PromoCodeHelper.PromoCodeManager();
        private List<string> errors = new List<string>();

        #region "Custom Methods"
        public void ApplyBuyTwoGetOnePromotion(List<string> promotionProductCodes) 
        {
            var applyPromotion = DtmContext.ShoppingCart.Where(sc => promotionProductCodes.Contains(sc.ProductCode) || sc.ProductCode.Contains("FREE")).Sum(sc => sc.Quantity) >= 3;
            var freeItems = DtmContext.ShoppingCart.Where(sc => sc.ProductCode.Contains("FREE")).ToList();

            if (applyPromotion)
            {
                var lastAdded = DtmContext.ShoppingCart.LastOrDefault(sc => promotionProductCodes.Contains(sc.ProductCode));
                var hasFreeItem = freeItems.Count > 0;

                if (lastAdded != null && !hasFreeItem)
                {
                    var newQuantity = (lastAdded.Quantity > 0) ? lastAdded.Quantity - 1 : 0;
                    var freeProductCode = (SubscriptionItems.Contains(lastAdded.ProductCode)) 
                        ? lastAdded.ProductCode.Substring(1, lastAdded.ProductCode.Length - 1) 
                        : lastAdded.ProductCode;
                    OrderManager.SetProductQuantity(lastAdded.ProductCode, newQuantity);
                    OrderManager.SetProductQuantity("FREE" + freeProductCode, 1);
                }
            }
            else
            {

                foreach (var freeItem in freeItems) 
                {
                    OrderManager.SetProductQuantity(freeItem.ProductCode, 0);
                }
            }
        }
        #endregion

        #region " Overrides... "

        public override void PostProcessPageActions()
        {
            //Checking for the pages code based on the main order pages array on line ten.
            if (DtmContext.Page.IsStartPageType)
            {
                Trace.WriteLine("Processing post page actions...");


                var itemAdded = Form.AllKeys.Where(k => k.Contains("Item")).OrderByDescending(k => k.Replace("Item", string.Empty)).FirstOrDefault() ?? string.Empty;
                var item = Form[itemAdded] as string;
                int quantity;
                var excludeCodes = new List<string>() { "SHIP", "SHIPSUB", "FREEF7V", "FREECPB", "FREESML", "FREECF7C", "FREECF7V", "FREECCPB", "FREECSML", "FREEF7C" };
                excludeCodes.AddRange(DtmContext.PromoCodeRules.Select(p => p.ProductCode));
                int.TryParse(Form["Qty" + itemAdded.Replace("Item", string.Empty)] as string, out quantity);
                if (!string.IsNullOrWhiteSpace(item) && quantity > 0 && !excludeCodes.Contains(item))
                {
                    var codeToRemove = SubscriptionItems.Contains(item) ? item.Substring(1, item.Length - 1) : "C" + item;
                    OrderManager.SetProductQuantity(codeToRemove, 0);

                    if (SubscriptionItems.Contains(codeToRemove))
                    {
                        OrderManager.SetProductQuantity("FREE" + codeToRemove.Substring(1, codeToRemove.Length - 1), 0);
                    }
                    else 
                    {
                        OrderManager.SetProductQuantity("FREE" + codeToRemove, 0);
                    }
                }

                if ((DtmContext.Page.PageCode == "Checkout"))
                {
                    if (DtmContext.Version >= 1)
                    {
                        var productCodes = new List<string>()
                       {  "F7C", "F7V", "CPB", "SML", "CF7C", "CF7V", "CCPB", "CSML",
                        "CMEG", "IMU", "CIMU", "RLX", "CRLX", "BBP", "CBBP", "BRN", "CBRN"  };


                        if (DtmContext.ShoppingCart.Any(x => productCodes.Contains(x.ProductCode)))
                        {
                            if (DtmContext.ShoppingCart.Any(sc => SubscriptionItems.Contains(sc.ProductCode)))
                            {
                                OrderManager.SetProductQuantity("SHIPSUB", 1);
                                OrderManager.SetProductQuantity("SHIP", 0);
                            }
                            else 
                            {
                                OrderManager.SetProductQuantity("SHIPSUB", 0);
                                OrderManager.SetProductQuantity("SHIP", 1);
                            }
                        }

                    }
                    if(DateTime.Now >= DateTime.Parse("06/01/23") && DateTime.Now < DateTime.Parse("06/04/23 11:59 PM") && !DtmContext.ShoppingCart.Any(sc=> DtmContext.PromoCodeRules.Any(p=> sc.ProductCode == p.PromoCode)))
                    {
                        OrderManager.SetProductQuantity("PROMOCODE25", 1);
                    }
                }

                var fathersDayPromotion = new FathersDayOffer();

                if (fathersDayPromotion.IsActive) 
                {
                    var promotionItems = new List<string>{ "F7V", "CF7V", "F7C", "CF7C", "CPB", "CCPB", "SML", "CSML" };
                    ApplyBuyTwoGetOnePromotion(promotionItems);
                }
            }
        }

        public override void OnProcessCustomPromoCode(PromoCodeRule promoCodeAction, SafeDictionary postData)
        {
            switch (promoCodeAction.PromoCode)
            {
                case "FLIPMYLIFENOW":
                    {
                        ProcessPromoDiscountWithExcludeCodes(promoCodeAction, PromoCodeItems.ExcludedItems[promoCodeAction.PromoCode]);
                    }
                    break;
            }
        }

        private void ProcessPromoDiscountWithExcludeCodes(PromoCodeRule promoCodeAction, List<string> excludeProductCodes)
        {
            OrderManager.SetProductQuantity(promoCodeAction.PromoCode, 1);
            var items = DtmContext.ShoppingCart.Items.Where(i => !excludeProductCodes.Contains(i.ProductCode) && i.Price.HasValue);
            var subTotal = items.Sum(i => i.Price.Value * i.Quantity);
            var discountPrice = Math.Round(subTotal * promoCodeAction.Value * -1, 2, MidpointRounding.AwayFromZero);

            DtmContext.ShoppingCart[promoCodeAction.PromoCode].Price = discountPrice;
            OrderManager.AddOrderCode(discountPrice.ToString(), promoCodeAction.PromoCode + "TransactionFee");
            ViewData["promoCodeTarget"] = promoCodeAction.PromoCode;
        }

        public override bool OnValidatePromoCodeAction(PromoCodeRule promoCodeAction)
        {
            switch (promoCodeAction.PromoCode)
            {
                case "FLIPMYLIFENOW":
                    if(DtmContext.ShoppingCart.All(i => PromoCodeItems.ExcludedItems[promoCodeAction.PromoCode].Contains(i.ProductCode)))
                    {
                        AddModelStateError("PromoCode", "FLIPMYLIFENOW does not apply to subscription products");
                        OrderManager.SetProductQuantity(promoCodeAction.PromoCode, 0);
                        return false;
                    }
                    return true;
                //case "WELCOME10":
                //    if(promoCodeManager.IsDuplicateHouseholdOrder(out errors, promoCodeAction.PromoCode, DtmContext.Order != null ? DtmContext.Order.Email : string.Empty))
                //    {
                //        AddModelStateError("PromoCode", "Promo code allowed for one time use per Email");
                //        OrderManager.SetProductQuantity(promoCodeAction.PromoCode, 0);
                //        return false;
                //    }
                //    return true;
                default:
                    return base.OnValidatePromoCodeAction(promoCodeAction);
            }
        }

        public override void PostValidate(ModelStateDictionary modelState)
        {
            if (DtmContext.Version == 99)
            {
                var subscription = Form["subscriptionCbx"] ?? string.Empty;
                var autoBill = Form["checkbox1"] ?? string.Empty;
                autoBill += Form["checkbox2"] ?? string.Empty;
                autoBill += Form["checkbox3"] ?? string.Empty;
                autoBill += Form["checkbox4"] ?? string.Empty;
          

                if (String.IsNullOrEmpty(subscription) && !String.IsNullOrEmpty(autoBill))
                {
                    modelState.AddModelError("Subscription", "Please check the Terms Checkbox.");
                }
            }


            if ((DtmContext.Page.PageCode == "OrderSummaryWithEdit"))
            {
                var productCodes = new List<string>()
                {
                    "F7C", "F7V", "CPB", "SML", "CF7C", "CF7V", "CCPB", "CSML"               
                };
                var totalQty = ActionItems.Where(data => productCodes.Contains(data.Key)).Sum(d => d.Value);

                if (totalQty < 1)
                {
                    AddModelStateError("form", "Please make sure a product quantity is selected to continue.");
                }
            }

            if(string.Equals(DtmContext.PageCode, "Checkout", StringComparison.InvariantCultureIgnoreCase))
            {
                var onePerEmailPromoQty = ActionItems.Where(data => data.Key == "WELCOME10").Sum(d => d.Value);
                if (onePerEmailPromoQty >= 1 && promoCodeManager.IsDuplicateHouseholdOrder(out errors, "WELCOME10", Form["Email"] ?? string.Empty))
                {
                    AddModelStateError("Form", "Promo code allowed for one time use per person.");
                    OrderManager.SetProductQuantity("WELCOME10", 0);
                }
            }

        }

        public override void PageLoaded(HttpRequestBase request, HttpResponseBase response)
        {
            // PROMO CODES ONLY ALLOWED ONE USE PER EMAIL

            if (DtmContext.ShoppingCart["WELCOME10"].Quantity > 0)
            {
                var cardType = DtmContext.Order.CardType ?? string.Empty;
                if (cardType.ToString().ToUpper() == "PAYPALEC" && promoCodeManager.IsDuplicateHouseholdOrder(out errors, "WELCOME10", DtmContext.Order.Email))
                {
                    OrderManager.SetProductQuantity("WELCOME10", 0);
                    foreach (var error in errors)
                    {
                        AddModelStateError("PromoCode", error);
                    }
                }
            }

            if (string.Equals(DtmContext.PageCode, "Confirmation", StringComparison.InvariantCultureIgnoreCase) && DtmContext.Order.Items["WELCOME10"].Quantity > 0
                   && !promoCodeManager.IsDuplicateHouseholdOrder(out errors, "WELCOME10", DtmContext.Order.Email))
            {
                promoCodeManager.AddHouseholdOrder(DtmContext.Order.OrderID);
            }
        }
        #endregion
    }
}
