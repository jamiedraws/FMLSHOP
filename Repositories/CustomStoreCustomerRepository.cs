using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Extensions;
using Dtm.Framework.Models.Ecommerce;
using Dtm.Framework.Models.Ecommerce.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FMLSHOP.Repositories
{
    public class CustomStoreCustomerRepository : StoreCustomerRepository
    {

        public CustomStoreCustomerRepository(EcommerceDataContext context) : base(context)
        { }

        internal bool IsExistingEmail(string email)
        {
            return Context.StoreCustomers.Any(sc => sc.CustomerId == DtmContext.CustomerId && sc.Email == email);
        }

        internal StoreCustomer GetAuthenticatedCustomer(string email, string password, int customerId)
        {
            // sc.CustomerId = null, DTM Global Store Customer
            // Support hashed passwords and legacy unhashed passwords
            var passwordHash = GetPaswordHash(password);
            return Context.StoreCustomers
                .FirstOrDefault(sc => (sc.CustomerId == null || sc.CustomerId == customerId)
                    && sc.Email == email
                    && (sc.Password == password || sc.Password == passwordHash));

        }

        internal StoreCustomer GetById(Guid storeCustomerId)
        {
            return Context.StoreCustomers.FirstOrDefault(sc => sc.StoreCustomerID == storeCustomerId);
        }

        internal string GetPaswordHash(string unhashedPassword)
        {
            return unhashedPassword.ToPasswordHash();
        }
    }
}