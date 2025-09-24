using System;
using System.IO;
using System.Web;
using System.Linq;
using System.Dynamic;
using System.Collections.Generic;
using ToSic.Razor.Blade;
using DotNetNuke.Entities.Tabs;



/*
  Embed in page with:

*/

public class Core : Custom.Dnn.Code12
{

   //* unique View ID 
   // (ovi uId i uID su failback za stare verzije i trebaju se izbrisat)
   //
   public string vwID {get; set;}
   public string uId {get; set;}
   public string uID {get; set;}
   
   // vraća bool True ako je korisnik u skupini koja može uređivat
   public bool UserCanEdit {get; set;}
   public bool UserCanAdmin {get; set;}
   public bool UserIsSuperUser {get; set;}
   
   // Dohvaća sve vrijednosti definirane u _settings.ascx teme
   public dynamic Settings {get; set;}

   public dynamic Context {get;set;}
   public string AppPath {get;set;}

   /*
      Magic begins here :)
   */
   public dynamic Init( dynamic HttpContextCurrent){

      vwID = uID = uId = GetUniqueID();
      UserCanEdit = CanUserEdit();
      UserCanAdmin = IsSuperUser();
      UserIsSuperUser = IsSuperUser();
      Context = HttpContextCurrent;
      Settings = Context.Items["themeSettings"];
      
      return this;
   }


   public string GetUniqueID() {
      return "vw-" + Guid.NewGuid().ToString("n").Substring(0, 8);
   }

   public bool CanUserEdit() {
      return Dnn.User.IsInRole("Editors") ? true : false;
   }

   private bool IsSuperUser() {
      return Dnn.User.IsInRole("Host") ? true : false;
   }



   public int GetTabIdFromSxcLink( dynamic sxcItem, string sxcLinkFieldName){
      if (sxcItem.Entity.Attributes[sxcLinkFieldName].Values[0].Serialized.Contains("page"))
      {
         var tabIDString = sxcItem.Entity.Attributes[sxcLinkFieldName].Values[0].Serialized.Replace("\"", "");
         return Int32.Parse(tabIDString.Split(':')[1]);
      }else{
         return -1;
      }
   }

   public TabInfo GetPageById( int tabId ) {
      return TabController.Instance.GetTab(tabId, CmsContext.Site.Id);
	}

   public HtmlString ViewDevInfo(dynamic virtualPath ){

      if(!UserCanAdmin) { return new HtmlString(""); }

      var templateFile = Path.GetFileNameWithoutExtension(Context.Server.MapPath(virtualPath));
      string presetsTemplate ="";

      if (Header != null && Header.Preset != null && !String.IsNullOrEmpty(Header.Preset.EntityTitle)) {
         presetsTemplate = "<section class='d-flex'>";
         presetsTemplate += "<div class='w-50'><strong>Wrapper Preset</strong>: "+Header.Preset.EntityTitle+"</div>";
         presetsTemplate += "<div class='w-50'><strong>Content Preset(s)</strong>: <ul>";
         if(Content != null) {
            foreach( var contentItem in Content) {
               if(contentItem.Preset != null) {
                  presetsTemplate += "<li class='item-preset'>"+contentItem.Preset.EntityTitle+"</li>";
               }
            }
         }
         presetsTemplate +="</ul></div></section>";
      }

      string infoTemplate = "<section class='dev__info js-dismissable mb-gw2 pt-1'><div class='d-flex justify-content-between'><div class='c-item'><strong>Dnn Pane:</strong> {0}</div><div class='c-item'><strong>ModuleID:</strong> {1}</div><div class='c-item'><strong>App:</strong> {2}</div><div class='c-item'><strong>View Template:</strong> {3}</div></div>{4}</section>";
      
      return new HtmlString(
         string.Format((string) infoTemplate
            , Dnn.Module.PaneName
            , Dnn.Module.ModuleID
            , App.Name
            , templateFile
            , presetsTemplate
         )
      );
   }
}
