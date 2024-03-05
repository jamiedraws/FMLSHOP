using Dtm.Framework.Base.Attributes;
using Dtm.Framework.Base.Configuration;
using Dtm.Framework.Base.Controllers;
using Dtm.Framework.ClientSites.Controllers;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.ClientSites.Web.ModelValidation;
using Dtm.Framework.Models.Ecommerce;
using Dtm.Framework.Models.Ecommerce.Repositories;
using FMLSHOP.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FMLSHOP.Repositories;
using Dtm.Framework.ClientSites;
using Dtm.Framework.Base.Caches.Models;

namespace FMLSHOP.Controllers
{
    public class ProfileController : AccountController
    {

        private readonly CustomStoreCustomerRepository _storeCustomerRepository;

        public ProfileController()
        {
            _storeCustomerRepository = new CustomStoreCustomerRepository(Context);
        }

        [Authorize]
        public ActionResult GetExclusiveContent()
        {
            SetContextByPageCode("Index");

            return View("ExclusiveContent", Model);
        }


        [AcceptVerbs(HttpVerbs.Get), NoCacheResponse]
        public ActionResult CreateAccount(AccountType accountType)
        {
            SetContextByPageCode("StoreCustomerProfile");
            var model = new OrderPageViewData(Model);
            model.Action = "CreateAccount";
            ViewData["AccountType"] = accountType;
            return View("StoreCustomerProfile", model);
        }

        [AcceptVerbs(HttpVerbs.Post), NoCacheResponse]
        public ActionResult CreateAccount(OrderPageViewData model, AccountType accountType)
        {
            if (Request.IsAuthenticated)
                ModelState.AddModelError("Form", SettingsManager.ContextSettings["Customer.LogoutBeforeLoggingInMessage", "Please log out before attempting to register."]);
            if (_storeCustomerRepository.IsExistingEmail(model.CurrentCustomer.Email))
                ModelState.AddModelError("Form", SettingsManager.ContextSettings["Customer.AccountAlreadyExistsMessage", "An account with this email already exists."]);

            var customer = GetValidStoreCustomerProfile(model);

            if (Request.Form["EmailOptInCbx"] != null && Request.Form["EmailOptInCbx"] == "on")
            {
                customer.AddCustomerCode("EmailOptIn", "true");
            }
            if (!ModelState.IsValid)
            {
                model.Categories = Model.Categories;
                SetContextByPageCode("StoreCustomerProfile");
                Model.Action = model.Action;
                return View("StoreCustomerProfile", Model);
            }

            DtmContext.StoreCustomerId = _storeCustomerRepository.Add(customer);
            FormsAuthentication.SetAuthCookie(customer.Email, true);
            UpdateVisitorSession();

            customer.MarkAsConsumerAccount();

            Context.SubmitChanges();
            return RedirectToAction("Index", "Account");
        }

        [AcceptVerbs(HttpVerbs.Post), NoCacheResponse]
        [Authorize]
        public ActionResult EditAddress(OrderPageViewData model)
        {
            var address = Model.CurrentCustomer.StoreCustomerAddresses
                .FirstOrDefault(a => a.StoreCustomerAddressID == model.BillingAddress.AddressId);

            if (address != null)
            {
                var isShippingParam = Request.Form["IsShipping"] ?? string.Empty;
                bool isShipping;
                bool.TryParse(isShippingParam, out isShipping);

                var isDefaultParam = Request.Form["IsDefault"] ?? string.Empty;
                bool isDefault;
                bool.TryParse(isDefaultParam, out isDefault);


                address.FirstName = model.BillingFirstName;
                address.LastName = model.BillingLastName;
                address.Street = model.BillingAddress.Street;
                address.Street2 = model.BillingAddress.Street2;
                address.City = model.BillingAddress.City;
                address.State = model.BillingAddress.State;
                address.Zip = model.BillingAddress.Zip;
                address.Country = model.BillingAddress.Country;
                address.IsShipping = isShipping;
                address.IsDefault = isDefault;
                address.ChangeDate = DateTime.Now;
                address.ChangeUser = FrameworkCommon.USER_NAME;


                new CustomerAddressValidator().ValidateModel(address, ModelState);

                if (ModelState.IsValid)
                {
                    if (address.IsDefault.HasValue && address.IsDefault.Value)
                    {
                        SetAddressDefault(isShipping, address.StoreCustomerAddressID);
                    }

                    Model.CurrentCustomer.ChangeDate = DateTime.Now;
                    Model.CurrentCustomer.ChangeUser = FrameworkCommon.USER_NAME;

                    _storeCustomerRepository.Update(Model.CurrentCustomer);
                    UpdateVisitorSession();
                }
            }
            return RedirectToAction("Profile", "Account");
        }

        [AcceptVerbs(HttpVerbs.Post), NoCacheResponse]
        [Authorize]
        public ActionResult AddAddress(OrderPageViewData model)
        {
            var isShippingParam = Request.Form["IsShipping"] ?? string.Empty;
            bool isShipping;
            bool.TryParse(isShippingParam, out isShipping);

            var isDefaultParam = Request.Form["IsDefault"] ?? string.Empty;
            bool isDefault;
            bool.TryParse(isDefaultParam, out isDefault);

            var address = new StoreCustomerAddress
            {
                StoreCustomerID = model.CurrentCustomer.StoreCustomerID,
                FirstName = model.BillingFirstName,
                LastName = model.BillingLastName,
                Street = model.BillingAddress.Street,
                Street2 = model.BillingAddress.Street2,
                City = model.BillingAddress.City,
                State = model.BillingAddress.State,
                Zip = model.BillingAddress.Zip,
                Country = model.BillingAddress.Country,
                IsShipping = isShipping,
                IsDefault = isDefault,
                AddUser = FrameworkCommon.USER_NAME,
                AddDate = DateTime.Now,
                ChangeUser = FrameworkCommon.USER_NAME,
                ChangeDate = DateTime.Now,
                StoreCustomerAddressID = Guid.NewGuid()
            };

            new CustomerAddressValidator().ValidateModel(address, ModelState);

            if (ModelState.IsValid)
            {
                if (address.IsDefault.HasValue && address.IsDefault.Value)
                {
                    SetAddressDefault(isShipping, address.StoreCustomerAddressID);
                }

                Model.CurrentCustomer.ChangeDate = DateTime.Now;
                Model.CurrentCustomer.ChangeUser = FrameworkCommon.USER_NAME;
                Model.CurrentCustomer.StoreCustomerAddresses.Add(address);
                
                _storeCustomerRepository.Update(Model.CurrentCustomer);
                UpdateVisitorSession();
                
            }
            else
            {
                
                var modelStateErrors = "<ul>"+ string.Join("",ViewData.ModelState.Values
               .SelectMany(ms => ms.Errors)
               .Select(me => "<li>" + me.ErrorMessage + "</li>"))+"</ul>";
                TempData["ModelErrors"] = modelStateErrors;

                return RedirectToAction("Profile", "Account", new { mode = "addAddress" });
            }

            return RedirectToAction("Profile", "Account");
        }

        [AcceptVerbs(HttpVerbs.Post), NoCacheResponse]
        [Authorize]
        public JsonResult DeleteAddress()
        {
            var addressIdParam = Request.Form["addressId"] ?? string.Empty;
            Guid addressId;
            Guid.TryParse(addressIdParam, out addressId);

            var address = Model.CurrentCustomer.StoreCustomerAddresses
               .FirstOrDefault(a => a.StoreCustomerAddressID == addressId);

            if(address != null)
            {

                Context.GetTable<StoreCustomerAddress>().DeleteOnSubmit(address);
                Model.CurrentCustomer.StoreCustomerAddresses.Remove(address);
                _storeCustomerRepository.Update(Model.CurrentCustomer);
                UpdateVisitorSession();
            }

            return new JsonResult() { JsonRequestBehavior = JsonRequestBehavior.DenyGet };
        }

        private void SetAddressDefault(bool isShipping, Guid addressId)
        {
            List<StoreCustomerAddress> addresses;
            if (addressId == Guid.Empty)
            {
                addresses = Model.CurrentCustomer.StoreCustomerAddresses.Where(a =>
                ((!a.IsShipping.HasValue && !isShipping)
                || (a.IsShipping.HasValue && (!a.IsShipping.Value && !isShipping))
                || (a.IsShipping.HasValue && a.IsShipping.Value && isShipping))
                && a.IsDefault.HasValue
                && a.IsDefault.Value
                ).ToList();
            }
            else
            {
                addresses = Model.CurrentCustomer.StoreCustomerAddresses.Where(a =>
                a.StoreCustomerAddressID != addressId
                && ((!a.IsShipping.HasValue && !isShipping)
                || (a.IsShipping.HasValue && (!a.IsShipping.Value && !isShipping))
                || (a.IsShipping.HasValue && a.IsShipping.Value && isShipping))
                && a.IsDefault.HasValue
                && a.IsDefault.Value
                ).ToList();
            }

            foreach (var address in addresses)
            {
                address.IsDefault = false;
            }
        }

        [AcceptVerbs(HttpVerbs.Post), NoCacheResponse]
        public ActionResult LoginAccount(OrderPageViewData model)
        {
            SetOfferVersion();
            var existingCustomer = _storeCustomerRepository.GetAuthenticatedCustomer(model.Login, model.Password, DtmContext.CustomerId);
            if (existingCustomer != null)
            {
                FormsAuthentication.SetAuthCookie(model.Login, true);

                DtmContext.StoreCustomerId = existingCustomer.StoreCustomerID;

                Context.SubmitChanges();
                UpdateVisitorSession();

                if (model.ReturnUrl != null)
                    return Redirect(model.ReturnUrl);

                SetContextByPageCode("Account");
                return RedirectToAction("Index", "Account", new { offer = DtmContext.OfferCode, version = DtmContext.Version });
            }

            ModelState.AddModelError("Form", SettingsManager.ContextSettings["Customer.InvalidLoginMessage", "Invalid login!"]);
            model.Categories = Model.Categories;
            SetContextByPageCode("Login");
            return View("Login", model);
        }

        [AcceptVerbs(HttpVerbs.Post), NoCacheResponse]
        public ActionResult CheckoutLogin(OrderPageViewData model)
        {
            var existingCustomer = _storeCustomerRepository.GetAuthenticatedCustomer(model.Login, model.Password, DtmContext.CustomerId);
            if (existingCustomer != null)
            {
                FormsAuthentication.SetAuthCookie(model.Login, true);

                DtmContext.StoreCustomerId = existingCustomer.StoreCustomerID;

                if (existingCustomer.IsProfessionalAccount())
                {
                    DtmContext.ShoppingCart.Clear();
                }

                Context.SubmitChanges();
                UpdateVisitorSession();

                model.CurrentCustomer = Model.CurrentCustomer;
            }
            else
            {
                TempData["loginError"] = "true";
            }
            return Redirect(string.Format("{0}{1}/{2}/{3}", DtmContext.Domain.FullDomain, DtmContext.OfferCode, DtmContext.Version, "Checkout" + DtmContext.ApplicationExtension));
        }

        [AcceptVerbs(HttpVerbs.Get), NoCacheResponse]
        public ActionResult LogoutAccount(string redirectOverride)
        {
            if (User.Identity.IsAuthenticated)
            {
                FormsAuthentication.SignOut();
                _visitorSessionManager.ClearSession();
            }
            var cver = "?cver=" + DtmContext.VersionId;
            string redirectUrl;
            if (!string.IsNullOrWhiteSpace(redirectOverride))
            {
                redirectUrl = "/" + redirectOverride;
            }
            else
            {
                redirectUrl = HttpContext.Request.UrlReferrer != null && !string.IsNullOrWhiteSpace(HttpContext.Request.UrlReferrer.AbsolutePath)
                ? HttpContext.Request.UrlReferrer.AbsolutePath
                : "/";
            }
            return Redirect(redirectUrl + cver);
        }

        private StoreCustomer GetValidStoreCustomerProfile(OrderPageViewData model)
        {
            if (!model.ShippingIsDifferentThanBilling)
                model.ShippingAddress.Load(model.BillingAddress);

            if (ModelState.IsValid)
            {
                if (model.CurrentCustomer.StoreCustomerID == Guid.Empty)
                {
                    model.CurrentCustomer.AddDate = DateTime.Now;
                    model.CurrentCustomer.AddUser = FrameworkCommon.USER_NAME;
                }
                model.CurrentCustomer.ChangeDate = DateTime.Now;
                model.CurrentCustomer.ChangeUser = FrameworkCommon.USER_NAME;

                model.CurrentCustomer.CustomerId = DtmContext.CustomerId;
            }

            return model.CurrentCustomer;
        }

        /// <summary>
        /// Determines the current offer code and version number based on an optional query string parameter "cver", representing the Guid Campaign Offer Version Id, or defaults to an explicit offer version.
        /// </summary>
        private void SetOfferVersion()
        {
            Guid covid = Guid.TryParse(Request["cver"], out covid) ? covid : Guid.Empty;

            if (covid != Guid.Empty && DtmContext.CampaignOfferVersions.Any(cov => cov.OfferVersionId == covid))
            {
                CampaignOfferVersionInformation offerVersion = DtmContext.CampaignOfferVersions.First(cov => cov.OfferVersionId == covid);

                DtmContext.OfferCode = offerVersion.OfferCode;
                DtmContext.Version = offerVersion.VersionNumber;
            }
        }

        private void SetContextByPageCode(string pageCode)
        {
            PageDefinition campaignPage = DtmContext.CampaignPages.FirstOrDefault(cp => cp.PageCode == pageCode);

            if (campaignPage != null)
            {
                DtmContext.Page = campaignPage;
                DtmContext.PageCode = campaignPage.PageCode;
            }

            MapModelPageInformation();
        }
    }
}