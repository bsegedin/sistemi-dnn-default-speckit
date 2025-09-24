using System;
using System.Linq;
using System.Collections.Generic;
using ToSic.Razor.Blade;

public class EditButtons : Custom.Dnn.Code12
{
/*
    TODO:
    Proslijedi Array Role-a u parametru, parametar optional, loopaj kroz role i ako user matcha role-u daj mu pristup
 */

   public string[] JustEdit() {
      return new [] {
         "toolbar=empty", "edit"
      };
   }
    public string[] EditAndDelete() {
      return new [] {
         "toolbar=empty", "edit", "delete&color=red"
      };
   }
   public string[] NewItemConfig( string sxcContentTypeName) {
      if (Dnn.User.IsInRole("Host") || Dnn.User.IsInRole("Administrators")) { 
         return new [] {
            "toolbar=empty"
            , "new&show=true?contentType=" + @sxcContentTypeName + "&entityId=0"
            , "app"
         };
      };
      return JustAdd (sxcContentTypeName);
   }
   public string[] JustAdd (string sxcContentTypeName) {
      return new [] {
         "toolbar=empty" 
         , "new&show=true?contentType=" + @sxcContentTypeName + "&entityId=0"
      };
   }
   public string[] AddAndPrefill (string sxcContentTypeName, string prefill = "" ) {
      return new [] {
         "toolbar=empty" 
         , "new&show=true?contentType=" + @sxcContentTypeName + "&entityId=0&prefill:" + prefill
      };
   }
   public string[] EditAddAndPrefill (string sxcContentTypeName, string prefill = "" ) {
      return new [] {
         "toolbar=empty", "edit"
         , "new&show=true?contentType=" + @sxcContentTypeName + "&entityId=0&prefill:" + prefill
      };
   }

   // umjesto Tag.Toolbar možemo pozvat ovo pa dobijemo uvjetne botune kod edit-a
   public dynamic TagToolbar ( dynamic _Content = null, string sxcContentTypeName = "", string position = "") {
      
      if (Dnn.User.IsInRole("Host") || Dnn.User.IsInRole("Administrators")) {
         
         if (!string.IsNullOrEmpty(position)) {
            return Edit.TagToolbar(_Content, settings:new {hover=position}); 
         }
         return Edit.TagToolbar(_Content); 
      }

      List<string> postToolbarConfig = new List<string>();
      postToolbarConfig.Add("-layout");
      postToolbarConfig.Add("-more");

      if(!string.IsNullOrEmpty(sxcContentTypeName)) {
         postToolbarConfig.Add("new&show=true?contentType=" + sxcContentTypeName);
      }

      return Edit.TagToolbar(_Content, toolbar: postToolbarConfig);
   }

   // posebni edit botuni za Articles app
   public dynamic EditArticles (dynamic _Content, string ArticleType = "Article" ) {

      if (Dnn.User.IsInRole("Host") || Dnn.User.IsInRole("Administrators")) { return Edit.TagToolbar(_Content); }

      List<string> postToolbarConfig = new List<string>();
      postToolbarConfig.Add("-layout");
      postToolbarConfig.Add("-more");
      postToolbarConfig.Add("-edit");
      //postToolbarConfig.Add("delete&show=true");
      
      var newItemString = "%new&show=true?contentType=BlogPost&entityId=0&prefill:PublicationMoment=" + DateTime.Now.ToString("yyyy-MM-dd");
      if(ArticleType == "Events") {
         newItemString += "&prefill:Event=True";
      }
      postToolbarConfig.Add(newItemString);

      return Edit.TagToolbar(_Content, toolbar: postToolbarConfig);
   }

}
