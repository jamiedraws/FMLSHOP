using Dtm.Framework.Base.Configuration;
using Dtm.Framework.ClientSites.Controllers;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.ClientSites.Web.ModelValidation;
using Dtm.Framework.Models.Ecommerce;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web.Security;
using FMLSHOP.Repositories;

namespace FMLSHOP.Classes
{
    public class CheckoutAccount : AccountController
    {
        private readonly CustomStoreCustomerRepository _storeCustomerRepository;
        private readonly OrderPageViewData _accountModel;
        private bool CreateAnAccount= false;
        private bool AddAnAddress= false;
        public CheckoutAccount(NameValueCollection form)
        {
            _storeCustomerRepository = new CustomStoreCustomerRepository(Context);
            _accountModel = CreateModel(form);
            CreateAnAccount = form["CreateAccountCbx"] != null && form["CreateAccountCbx"] == "on";
            AddAnAddress = form["SaveInfoCbx"] != null && form["SaveInfoCbx"] == "on";
        }
        public void Initialize()
        {
            if (CreateAnAccount)
            {
                CreateAccount();
            }
            else if (AddAnAddress)
            {
                AddAddress();
            }
        }
        private OrderPageViewData CreateModel(NameValueCollection Form)
        {
            return new OrderPageViewData()
            {
                ShippingIsDifferentThanBilling = Form["ShippingIsDifferentThanBilling"].Contains("true"),
                BillingFirstName = Form["BillingFirstName"] ?? string.Empty,
                BillingLastName = Form["BillingLastName"] ?? string.Empty,
                BillingAddress =
                {
                    Street = Form["BillingStreet"] ?? string.Empty,
                    Street2 = Form["BillingStreet2"] ?? string.Empty,
                    City = Form["BillingCity"] ?? string.Empty,
                    State = Form["BillingState"] ?? string.Empty,
                    Zip = Form["BillingZip"] ?? string.Empty,
                    Country = Form["BillingCountry"] ?? string.Empty
                },
                ShippingFirstName = Form["ShippingFirstName"] ?? string.Empty,
                ShippingLastName = Form["ShippingLastName"] ?? string.Empty,
                ShippingAddress =
                {
                    Street = Form["ShippingStreet"] ?? string.Empty,
                    Street2 = Form["ShippingStreet2"] ?? string.Empty,
                    City = Form["ShippingCity"] ?? string.Empty,
                    State = Form["ShippingState"] ?? string.Empty,
                    Zip = Form["ShippingZip"] ?? string.Empty,
                    Country = Form["ShippingCountry"] ?? string.Empty
                },
                CurrentCustomer = {
                    StoreCustomerID = DtmContext.StoreCustomerId,
                    Email = Form["Email"] ?? string.Empty,
                    Password = Form["CurrentCustomer.Password"] ?? string.Empty
                },
                IsDefault = false
            };
        }
        public void CreateAccount()
        {
            var model = _accountModel;
            if (!_storeCustomerRepository.IsExistingEmail(model.CurrentCustomer.Email))
            {
                var customer = GetValidStoreCustomerProfile(model);

                DtmContext.StoreCustomerId = _storeCustomerRepository.Add(customer);
                FormsAuthentication.SetAuthCookie(customer.Email, true);
                UpdateVisitorSession();

                Context.SubmitChanges();
            }
        }

        public void AddAddress()
        {
            var model = _accountModel;
            var billingAddress = new StoreCustomerAddress
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
                IsShipping = false,
                IsDefault = false,
                AddUser = FrameworkCommon.USER_NAME,
                AddDate = DateTime.Now,
                ChangeUser = FrameworkCommon.USER_NAME,
                ChangeDate = DateTime.Now,
                StoreCustomerAddressID = Guid.NewGuid()
            };

            var shippingAddress = new StoreCustomerAddress
            {
                StoreCustomerID = model.CurrentCustomer.StoreCustomerID,
                FirstName = model.ShippingFirstName,
                LastName = model.ShippingLastName,
                Street = model.ShippingAddress.Street,
                Street2 = model.ShippingAddress.Street2,
                City = model.ShippingAddress.City,
                State = model.ShippingAddress.State,
                Zip = model.ShippingAddress.Zip,
                Country = model.ShippingAddress.Country,
                IsShipping = true,
                IsDefault = false,
                AddUser = FrameworkCommon.USER_NAME,
                AddDate = DateTime.Now,
                ChangeUser = FrameworkCommon.USER_NAME,
                ChangeDate = DateTime.Now,
                StoreCustomerAddressID = Guid.NewGuid()
            };

            new CustomerAddressValidator().ValidateModel(billingAddress, ModelState);
            if (ModelState.IsValid)
            {
                Model.CurrentCustomer.ChangeDate = DateTime.Now;
                Model.CurrentCustomer.ChangeUser = FrameworkCommon.USER_NAME;
                Model.CurrentCustomer.StoreCustomerAddresses.Add(billingAddress);

                _storeCustomerRepository.Update(Model.CurrentCustomer);
                UpdateVisitorSession();
            }
            else
            {
                var modelStateErrors = "<ul>" + string.Join("", ViewData.ModelState.Values
                   .SelectMany(ms => ms.Errors)
                   .Select(me => "<li>" + me.ErrorMessage + "</li>")) + "</ul>";
                TempData["ModelErrors"] = modelStateErrors;
            }

            if (model.ShippingIsDifferentThanBilling)
            {
                new CustomerAddressValidator().ValidateModel(shippingAddress, ModelState);

                if (ModelState.IsValid)
                {
                    Model.CurrentCustomer.ChangeDate = DateTime.Now;
                    Model.CurrentCustomer.ChangeUser = FrameworkCommon.USER_NAME;
                    Model.CurrentCustomer.StoreCustomerAddresses.Add(shippingAddress);

                    _storeCustomerRepository.Update(Model.CurrentCustomer);
                    UpdateVisitorSession();
                }
                else
                {
                    var modelStateErrors = "<ul>" + string.Join("", ViewData.ModelState.Values
                       .SelectMany(ms => ms.Errors)
                       .Select(me => "<li>" + me.ErrorMessage + "</li>")) + "</ul>";
                    TempData["ModelErrors"] = modelStateErrors;
                }
            }
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
    }
}