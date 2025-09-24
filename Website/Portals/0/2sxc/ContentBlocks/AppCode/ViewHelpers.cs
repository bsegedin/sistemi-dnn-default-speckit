using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.DynamicData;
using ToSic.Razor.Html5;
using ToSic.Sxc.Services;
using ToSic.Sxc.Context;


namespace AppCode
{
    public class ViewHelpers
    {
        /// <summary>
        /// Get string based on a different conditions. Method always returns textWhenConditionMet.
        /// Condition 1: Condition is met if string textWhenConditionMet is not null or empty.
        /// Condition 2: Condition is met if string additionalStringCondition is not null or empty and is not "none".
        /// Condition 3: Condition is met if boolean aditionalBoolCondition is TRUE.
        /// </summary>
        public string GetStringByCondition(string textWhenConditionMet, string textWhenConditionNotMet = "", int conditionType = 1, string additionalStringCondition = "none", bool aditionalBoolCondition = true)
        {
            bool conditionMet = false;

            switch (conditionType)
            {
                // Used to check if string is not null or empty.
                // USE: @viewHelpers.GetStringByCondition(textWhenConditionMet, textWhenConditionNotMet) - use if you want textWhenConditionNotMet string different then empty string
                // USE: @viewHelpers.GetStringByCondition(textWhenConditionMet)
                case 1:
                    conditionMet = !string.IsNullOrEmpty(textWhenConditionMet);
                    break;
                // Used to get strings based on additional string condition.
                // USE: @viewHelpers.GetStringByCondition(textWhenConditionNotMet, textWithConditionNotMet, 2, additionalStringCondition)
                case 2:
                    conditionMet = !string.IsNullOrEmpty(additionalStringCondition) && additionalStringCondition != "none";
                    break;
                // Used to get strings based on additional boolean condition.
                // USE: @viewHelpers.GetStringByCondition(textWhenConditionNotMet, textWithConditionNotMet, 3, "", aditionalBoolCondition)
                case 3:
                    conditionMet = aditionalBoolCondition == true;
                    break;
                default:
                    conditionMet = false;
                    break;
            }

            return conditionMet ? textWhenConditionMet : textWhenConditionNotMet;
        }


        /// <summary>
        /// Method is used to generate CSS class list based on different number of attributes.
        /// </summary>
        public string CreateCssClassList(List<string> baseCssClassList, params string[] additionalClasses)
        {
            if (baseCssClassList == null)
                baseCssClassList = new List<string>();

            foreach (var cls in additionalClasses)
            {
                if (!string.IsNullOrEmpty(cls))
                {
                    baseCssClassList.Add(cls);
                }
            }

            return string.Join(" ", baseCssClassList);
        }


        /// <summary>
        /// Obsolete method, use CreateCssClassList instead.
        /// </summary>
        public string GenerateWrapperClasses(List<string> mainClasses, string containerType, string bgColor, string modifiers)
        {
            // Add background color class if set
            if (!string.IsNullOrEmpty(bgColor) && bgColor != "none")
            {
                mainClasses.Add(bgColor);
            }

            // Add container type class if set
            if (!string.IsNullOrEmpty(containerType))
            {
                mainClasses.Add(containerType);
            }

            // Add text color class if set
            if (!string.IsNullOrEmpty(modifiers) && modifiers != "none")
            {
                mainClasses.Add(modifiers);
            }

            // Join classes into a single string
            string wrapperClasses = string.Join(" ", mainClasses);

            return wrapperClasses;
        }


        /// <summary>
        /// Method is used to convert a comma-separated list of strings to a space-separated list and remove "none" values.
        /// </summary>
        public string ConvertCommaListToSpaceList(string commaList)
        {
            if (string.IsNullOrEmpty(commaList))
            {
                return string.Empty;
            }

            // Split the commaList into an array
            var items = commaList.Split(',');

            // Remove "none" from the array
            var filteredItems = items.Where(item => item.Trim().ToLower() != "none");

            // Join the filtered items with spaces
            return string.Join(" ", filteredItems);
        }


        // Create the aspect ratio attribute for Bootstrap
        public string CreateBsAspectRatioAttribute(string ratioFormat)
        {
            var ratioParts = ratioFormat.Split(':');
            double x = Convert.ToDouble(ratioParts[0]);
            double y = Convert.ToDouble(ratioParts[1]);
            int aspectRatioPercent = (int)Math.Round((y / x) * 100);
            return $"--bs-aspect-ratio: {aspectRatioPercent}%;";
        }


        // Create the aspect ratio class for Bootstrap
        public string CreatioBsRatioClass(string ratioFormat)
        {
            return "ratio ratio-" + ratioFormat.Replace(":", "x");
        }


        /// <summary>
        /// Calculate the height of an image based on its aspect ratio
        /// </summary>
        public int CalculateImageHeight(string aspectRatio, int width)
        {
            if (string.IsNullOrEmpty(aspectRatio) || width <= 0)
            {
                throw new ArgumentException("Invalid aspect ratio or width");
            }

            var ratioParts = aspectRatio.Split(':');
            if (ratioParts.Length != 2 || !int.TryParse(ratioParts[0], out int x) || !int.TryParse(ratioParts[1], out int y) || x <= 0 || y <= 0)
            {
                throw new ArgumentException("Aspect ratio must be in the format X:Y with positive integers");
            }

            return (width * y) / x;
        }
    }
}
