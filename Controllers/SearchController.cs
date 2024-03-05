using Dtm.Framework.Base.Controllers;
using Dtm.Framework.ClientSites.Web;
using System.Data;
using System.Web.Mvc;
using System.Linq;
using System.Text.RegularExpressions;
using FMLSHOP.CampaignProduct;

namespace FMLSHOP.Controllers
{
 
    public class SearchController : DtmContextController
    {
        public ActionResult Search(string text)
        {
            var version = Request.Form["versionNumber"] ?? "";
            var offer = DtmContext.OfferCode;

            switch (offer)
            {
                case "UPGRADE":
                    return SearchByUpgradeOfferSolution(text, offer, version);
                default:
                    return SearchByDefaultOfferSolution(text, offer, version);
            }
        }

        private bool MatchesReplacementPage(string text)
        {
            return Regex.IsMatch(text, "^replacement head|head|heads$", RegexOptions.IgnoreCase);
        }

        private bool MatchesHowToPage(string text)
        {
            return Regex.IsMatch(text, "^how to|instructions|instruct|instruction$", RegexOptions.IgnoreCase);
        }

        private ActionResult SearchByDefaultOfferSolution(string text, string offer, string version)
        {
            if (MatchesReplacementPage(text))
            {
                return Redirect("/" + offer + "/" + version + "/REPLACEMENT" + DtmContext.ApplicationExtension + "#dv_Replace");
            }
            else if (MatchesHowToPage(text))
            {
                return Redirect("/" + offer + "/" + version + "/HowTo" + DtmContext.ApplicationExtension);
            }
            else
            {
                var regexMatchList = DtmContext.CampaignProducts.Where(cp => cp.CategoryIndexer.Has("SEARCH") &&
                    Regex.IsMatch(cp.ProductName ?? string.Empty, text, RegexOptions.IgnoreCase)
                    || Regex.IsMatch(cp.DisplayText ?? string.Empty, text, RegexOptions.IgnoreCase)
                    || Regex.IsMatch(cp.ShortName ?? string.Empty, text, RegexOptions.IgnoreCase)).ToList();

                var filteredList = regexMatchList.Where(p => (p.ProductType != "Option" && p.ProductType != "Shipping" && p.ProductType != "None" && p.CategoryIndexer.Has("SEARCH"))).ToList();

                TempData["Products"] = filteredList;


                return Redirect("/" + offer + "/" + version + "/SearchResults?query=" + text);
            }
        }

        private ActionResult SearchByUpgradeOfferSolution(string text, string offer, string version)
        {
            if (MatchesReplacementPage(text))
            {
                return Redirect("/" + offer + "/" + version + "/Replacement" + DtmContext.ApplicationExtension);
            }

            if (MatchesHowToPage(text))
            {
                return Redirect("/" + offer + "/" + version + "/HowTo" + DtmContext.ApplicationExtension);
            }

            ProductSearch productSearch = new ProductSearch();

            productSearch
                .GetSearchableProducts()
                .FilterByQuery(text, false)
                .FilterByProductType();

            Session["Products"] = productSearch.CampaignProducts;

            return Redirect("/" + offer + "/" + version + "/SearchResults?query=" + text);
        }
    }
}