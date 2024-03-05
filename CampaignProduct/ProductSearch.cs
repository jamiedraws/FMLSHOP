using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Base.Models;

namespace FMLSHOP.CampaignProduct
{
    public class ProductSearch
    {

        public List<CampaignProductView> CampaignProducts { get; private set; }
        public ProductSearch(List<CampaignProductView> campaignProducts = null)
        {
            CampaignProducts = GetApprovedProducts(campaignProducts);
        }

        public ProductSearch GetSearchableProducts()
        {

            var campaignProducts = DtmContext
                .CampaignProducts
                .Where(cp => string.Equals(cp.PropertyIndexer["IsSearchable"], "true", StringComparison.InvariantCultureIgnoreCase));

            if (!DtmContext.IsStage)
            {
                campaignProducts = campaignProducts
                    .Where(cp => !string.Equals(cp.PropertyIndexer["IsLive"], "false", StringComparison.InvariantCultureIgnoreCase));
            }

            CampaignProducts = GetApprovedProducts(campaignProducts);
            return this;
        }

        public ProductSearch FilterByProductType()
        {
            CampaignProducts = CampaignProducts.Where(
                cp => cp.ProductType != "Option" &&
                cp.ProductType != "Shipping" &&
                cp.ProductType != "None"
            ).ToList();

            return this;
        }

        public ProductSearch OrderByDisplayRank()
        {
            CampaignProducts = CampaignProducts.OrderBy(cp => cp.DisplayRank).ToList();

            return this;
        }

        public ProductSearch FilterByQuery(string query, bool isRelatedProducts)
        {
            var splitQuery = query.Split().Distinct().ToList();
            var filteredProducts = new List<CampaignProductView>();
            var campaignProductsSelected = new List<CampaignProductView>();
            var exactMatch = CampaignProducts
                    .Where(cp => Regex.IsMatch(cp.ProductName, Regex.Escape(query), RegexOptions.IgnoreCase))
                    .ToList();

            if (exactMatch.Any())
            {
                exactMatch.ForEach(ex => campaignProductsSelected.Insert(0, ex));
            }
            else
            {
                var productWithMostMatches = new Dictionary<CampaignProductView, int>();
                List<CampaignProductView> searchProducts, searchResults = new List<CampaignProductView>();

                foreach (var word in splitQuery)
                {
                    var closeMatch = CampaignProducts
                        .Where(cp => Regex.IsMatch(cp.ProductName ?? string.Empty, Regex.Escape(word), RegexOptions.IgnoreCase))
                        .ToList();

                    var anyMatch = isRelatedProducts
                        ? CampaignProducts
                        .Where(cp =>
                            Regex.IsMatch(cp.ProductName ?? string.Empty, Regex.Escape(word), RegexOptions.IgnoreCase))
                        .ToList()
                        : CampaignProducts
                        .Where(cp => (
                           Regex.IsMatch(cp.ProductName ?? string.Empty, Regex.Escape(word), RegexOptions.IgnoreCase) ||
                           Regex.IsMatch(cp.MetaKeywords ?? string.Empty, Regex.Escape(word), RegexOptions.IgnoreCase) ||
                           Regex.IsMatch(cp.ProductSku ?? string.Empty, Regex.Escape(word), RegexOptions.IgnoreCase) ||
                           Regex.IsMatch(cp.PropertyIndexer["ProductUPC"] ?? string.Empty, Regex.Escape(word), RegexOptions.IgnoreCase)))
                          .ToList();

                    searchProducts = closeMatch.Any() ? closeMatch : anyMatch;

                    foreach (var product in searchProducts)
                    {
                        if (productWithMostMatches.ContainsKey(product))
                        {
                            var valueRank = productWithMostMatches[product];
                            valueRank++;
                            productWithMostMatches[product] = valueRank;
                        }
                        else
                        {
                            productWithMostMatches.Add(product, 1);
                        }

                    }
                }
                var orderedResults = productWithMostMatches
                    .OrderByDescending(pc => pc.Value)
                    .ToList();

                searchResults = orderedResults.Select(or => or.Key).ToList();

                campaignProductsSelected = searchResults;
            }

            filteredProducts.AddRange(campaignProductsSelected);
            filteredProducts = filteredProducts.Distinct(new ItemEqualityComparer()).ToList();
            CampaignProducts = filteredProducts;

            return this;
        }


        public ProductSearch FilterPdpProduct(string pdpProductCode)
        {
            CampaignProducts = CampaignProducts.Where(cp => !Regex.IsMatch(cp.ProductCode, pdpProductCode, RegexOptions.IgnoreCase)).ToList();

            return this;
        }

        public bool HasProducts()
        {
            return CampaignProducts != null;
        }

        public bool HasResults()
        {
            return HasProducts() && CampaignProducts.Any();
        }

        private List<CampaignProductView> GetApprovedProducts(IEnumerable<CampaignProductView> campaignProducts)
        {
            var results = new List<CampaignProductView>();
            if (campaignProducts != null)
            {
                var allCategories = DtmContext.CampaignCategories.Select(c => c.Code);

                foreach (var category in allCategories)
                {
                    results.AddRange(campaignProducts.Where(cp => cp.CategoryIndexer.Has(category)));
                }
            }

            return results;
        }
    }

    internal class ItemEqualityComparer : IEqualityComparer<CampaignProductView>
    {
        public bool Equals(CampaignProductView x, CampaignProductView y)
        {
            // Two items are equal if their keys are equal.
            return x.ProductCode == y.ProductCode;
        }

        public int GetHashCode(CampaignProductView obj)
        {
            return obj.ProductCode.GetHashCode();
        }
    }
}