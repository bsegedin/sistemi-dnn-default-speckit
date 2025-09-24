using System;
using System.Collections.Generic;
using System.Linq;

namespace Core {
    public class CoreHelpers
    {
        public static List<dynamic> FilterContent(IEnumerable<dynamic> content, bool isAnonymous)
        {
            var filteredContent = new List<dynamic>();

            foreach (var item in content)
            {
                var isDemo = item.IsDemoItem ?? false;
                if (!(isDemo && isAnonymous))
                {
                    filteredContent.Add(item);
                }
            }

            return filteredContent;
        }

        public static string GetBadgeClass(dynamic item)
        {
            if (item.IsDemoItem == true)
            {
                return "bg-warning";
            }
            else if (item.isPublished == false)
            {
                return "bg-danger";
            }
            else
            {
                return "bg-success";
            }
        }

        public static string GetBadgeText(dynamic item)
        {
            if (item.IsDemoItem == true)
            {
                return "DEMO";
            }
            else if (item.isPublished == false)
            {
                return "UNPUB";
            }
            else
            {
                return "PUB";
            }
        }
    }
}
