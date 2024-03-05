<%@ WebHandler Language="C#" Class="GetProductImageByProductCode" %>

using System.Data;
using System.Web;
using System.Linq;
using Dtm.Framework.ClientSites.Web;
using FMLSHOP.CampaignProduct;
using System.Collections.Generic;

public class GetProductImageByProductCode : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;

        string productCode = request["productCode"];
        string imagePath = request["imagePath"] ?? "images/products/";
        string html = string.Empty;

        var captureCampaignProduct = DtmContext.CampaignProducts.Where(cp => cp.ProductCode == productCode);

        if (captureCampaignProduct.Any())
        {
            var campaignProduct = captureCampaignProduct.FirstOrDefault();
            string imageCode = campaignProduct.ProductCode ?? string.Empty;

            ProductImages productImages = new ProductImages(imageCode, imagePath + imageCode);
            List<string> images = productImages.GetFallbackImages(productImages.GetImagesByNamePattern("thumbnail"));

        if (!images.Any())
        {
            // if there is not a image within product code folder, attempt to grab on the url slug
            imageCode = campaignProduct.PropertyIndexer["IsVariantOf"] ?? campaignProduct.PropertyIndexer["IsRelatedTo"] ?? string.Empty;
            productImages = new ProductImages(imageCode, imagePath + imageCode);
            images = productImages.GetFallbackImages(productImages.GetImagesByNamePattern("thumbnail"));
        }

        if (images.Any())
        {
            string fallbackImage = images.FirstOrDefault();
            html = productImages.BuildHTMLPictureElement(fallbackImage, true);
        }

    }

    context.Response.Write(html);
    }

public bool IsReusable
{
    get
    {
        return true;
    }
}
}
