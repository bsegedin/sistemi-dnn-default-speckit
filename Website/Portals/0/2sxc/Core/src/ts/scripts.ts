"use strict";

function parseMarkdown( intoElement, mdString )
{
   var md = window.markdownit();
   var result = md.render(mdString);

   var mdElement = document.querySelector(intoElement);
   if (mdElement) {
      mdElement.classList.add('markdown-body');
      mdElement.innerHTML = result;
      mdElement.querySelectorAll('pre code').forEach(el => {
         hljs.highlightElement(el);
      });
   }
}

(window as any).parseMarkdown = parseMarkdown;