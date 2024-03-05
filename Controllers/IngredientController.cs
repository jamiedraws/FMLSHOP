using Dtm.Framework.Base.Attributes;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.ClientSites.Web.Controllers;
using System.Web.Mvc;

namespace FMLSHOP.Controllers
{
    public class IngredientController : ClientSiteController<ClientSiteViewData>
    {
        [AcceptVerbs(HttpVerbs.Get), NoCacheResponse]
        public ActionResult RenderIngredientViewBySlug(string ingredient)
        {
            string permissionKey = Request.Headers["PermissionKey"] ?? string.Empty;
            bool hasPermission = permissionKey.Equals(DtmContext.VersionId.ToString());

            if (hasPermission)
            {
                ViewData["Ingredient"] = ingredient ?? string.Empty;

                return View("ViewIngredient");
            }
            else
            {
                return Redirect(string.Format("/{0}/{1}/Index{2}", DtmContext.OfferCode, DtmContext.Version, DtmContext.ApplicationExtension));
            }
        }
    }
}