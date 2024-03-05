using Dtm.Framework.Models.Ecommerce;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FMLSHOP.Classes
{
    public static class StoreCustomerExtensions
    {
        private static readonly string _customerTypeLabel = "CustomerType";
        private static readonly string _professionalCustomerTypeCode = "Professional";
        public static bool IsProfessionalAccount(this StoreCustomer customer)
        {
            if (customer == null)
            {
                return false;
            }
            return string.Equals(customer.Codes[_customerTypeLabel].Code, _professionalCustomerTypeCode);
        }

        public static void MarkAsProfessionalAccount(this StoreCustomer customer)
        {
            if (customer != null)
            {
                customer.AddCustomerCode(_customerTypeLabel, _professionalCustomerTypeCode);
            }
        }

        public static void MarkAsConsumerAccount(this StoreCustomer customer)
        {
            if (customer != null)
            {
                customer.AddCustomerCode(_customerTypeLabel, "Consumer");
            }
        }

        public static bool IsMagentoProfessional(this StoreCustomer customer)
        {
            if(customer == null)
            {
                return false;
            }
            return string.Equals(customer.Codes["MagentoStoreId"].Code, "2") || string.Equals(customer.Codes["MagentoWebsiteId"].Code, "2");
        }

        public static bool IsVerifiedProfessional(this StoreCustomer customer)
        {
            if(customer == null)
            {
                return false;
            }

            return customer.IsProfessionalAccount() && customer.IsMagentoProfessional();
        }

    }
}