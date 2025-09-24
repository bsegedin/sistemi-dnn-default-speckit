

/*
   Image Not Downloaded ERROR handler
*/
function imgNotFoundError(image) {
   image.onerror = "";
   image.src = "/Portals/0/images/brand/edn-feed-not-downloaded.jpg?w=240&h=198&mode=crop";
   return true;
}

function renderSwiperMarkup(items) {

   let galleryImageMarkup = `<swiper-container style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff" class="swiper-gallery-stage" thumbs-swiper=".swiper-gallery-nav" navigation="true">`;
   let galleryThumbMarkup = `<swiper-container class="swiper-gallery-nav" space-between="10" slides-per-view="4" free-mode="true" watch-slides-progress="true">`;

   items.forEach((item) => {

      //thumb iz postojeće galerije koji se koristi kao thumb u swiper galeriji
      const imgThumbElement = item.querySelector("img");

      //izvlačenje podataka iz postojeće galerije
      imgObject = JSON.parse(item.dataset.smbdata);
      imgObject.imgTitle = imgObject.title != undefined ? imgObject.title.split("</span")[0].split(">")[1] : "";
      imgObject.imgDescription = imgObject.title != undefined ? imgObject.title.split("</span")[1].split(">")[2] : "";

      //kreiranje markupa glavne galerije
      if(imgObject.type === "image")
      {
      galleryImageMarkup += `<swiper-slide>
            <picture>
            <source type="image/webp" media="(min-width: 992px)" srcset="${imgObject.src}?w=1920&scale=both&mode=crop&quality=75 1920w">
            <source type="image/webp" media="(min-width: 601px) and (max-width: 991px)" srcset="${imgObject.src}?w=960&scale=both&mode=crop&quality=75 960w">
            <source type="image/webp" media="(max-width: 600px)" srcset="${imgObject.src}?w=512&scale=both&mode=crop&quality=75 512w">
            <img class="glightbox" alt="${imgObject.imgTitle}" data-title="${imgObject.imgTitle}" data-description="${imgObject.imgDescription}" data-desc-position="bottom" loading="lazy" src="${imgObject.src}?w=1920&scale=both&mode=crop&quality=75">
            </picture>
         </swiper-slide>`;
      //kreiranje markupa nav galerije
      galleryThumbMarkup += `<swiper-slide><img src="${imgThumbElement.src}?w=97&h=97&scale=both&mode=crop&quality=75""></swiper-slide>`;
      }
      else if(imgObject.type === "video")
      {
         const ytId = new URL(item.href).searchParams.get("v");
         galleryImageMarkup += `<swiper-slide>
            <iframe style="width:100%;" height="350" src="https://www.youtube.com/embed/${ytId}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay;" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
         </swiper-slide>`;
         //kreiranje markupa nav galerije
         galleryThumbMarkup += `<swiper-slide><img src="${imgThumbElement.src}?w=150&h=150&scale=both&mode=crop&quality=90""></swiper-slide>`;  
      }
   });

   galleryImageMarkup += `</swiper-container>`;
   galleryThumbMarkup += `</swiper-container>`;

   //append obiju kreiranih galerija u kontejner
   document.querySelector(".js-swiper-gallery").insertAdjacentHTML("afterbegin", galleryImageMarkup)
   document.querySelector(".js-swiper-gallery").insertAdjacentHTML("beforeend", galleryThumbMarkup)
}

function renderMosaicMarkup(items) {

   const galleryMosaicContainer = document.querySelector(".js-mosaic-container");
   //ovaj view prikazuje 3 slike
   const shownImagesCount = 3;

   let galleryImageMarkup = ``;

   //ukoliko bude samo jedna slika u galeriji
   if (items.length === 1 && galleryMosaicContainer.classList.contains("l-gallery-grid--mosaic")) {
      galleryMosaicContainer.classList.remove("l-gallery-grid--mosaic");
      galleryMosaicContainer.classList.add("l-gallery-grid--js-single-item");
   }

   items.forEach((item, idx) => {
      imgObject = JSON.parse(item.dataset.smbdata);

      imgObject.imgTitle = imgObject.title != undefined ? imgObject.title.split("</span")[0].split(">")[1] : "";
      imgObject.imgDescription = imgObject.title != undefined ? imgObject.title.split("</span")[1].split(">")[2] : "";

      galleryImageMarkup += `<div class="gallery-grid__item--${idx + 1}" data-item-data="{"mediaId":${imgObject.id},"likes":{"numberOf":${imgObject.likes.numOfLikes},"likedByUser":${imgObject.likes.likedByUser}}}" style="display:${idx < shownImagesCount ? "block" : "none"}">
          <picture>
              <source type="image/webp" media="(min-width: 992px)" srcset="${imgObject.src}?w=1920&scale=both&mode=crop&quality=75 1920w">
              <source type="image/webp" media="(min-width: 601px) and (max-width: 991px)" srcset="${imgObject.src}?w=960&scale=both&mode=crop&quality=75 960w">
              <source type="image/webp" media="(max-width: 600px)" srcset="${imgObject.src}?w=512&scale=both&mode=crop&quality=75 512w">
              <img class="gallery-grid__item glightbox" alt="${imgObject.imgTitle}" data-title="${imgObject.imgTitle}" data-description="${imgObject.imgDescription}" data-desc-position="bottom" data-width="1920" data-max-width="100%" data-max-height="550px" data-ratio="880/450" loading="lazy" src="${imgObject.src}?w=1920&scale=both&mode=crop&quality=75">
          </picture>
          </div>`;
   })

   //botun sa oznakom broja slika koje se ne vide
   if (items.length > shownImagesCount) {
      galleryImageMarkup += `<button class="js-hidden-images-count l-gallery-grid__item-count-number">
              <span>+${items.length - shownImagesCount}</span>
          </button>`;
   }
   galleryMosaicContainer.insertAdjacentHTML("afterbegin", galleryImageMarkup);

   if(document.querySelector(".js-hidden-images-count")){
      document.querySelector(".js-hidden-images-count").addEventListener("click", (e) => {
         e.preventDefault();
         console.log(document.querySelector(`.gallery-grid__item--${shownImagesCount + 1}`))
         document.querySelector(`.gallery-grid__item--${shownImagesCount + 1} img`).click();
      });
   }
}

function renderBasicSwiper(items) {
   let galleryImageMarkup = `<div class="swiper-wrapper">`;

   items.forEach((item) => {

      //izvlačenje podataka iz postojeće galerije
      imgObject = JSON.parse(item.dataset.smbdata);

      //kreiranje markupa galerije
      galleryImageMarkup += `<div class="swiper-slide">
            <picture>
            <source type="image/webp" media="(min-width: 992px)" srcset="${imgObject.src}?w=1920&scale=both&mode=crop&quality=75 1920w">
            <source type="image/webp" media="(min-width: 601px) and (max-width: 991px)" srcset="${imgObject.src}?w=960&scale=both&mode=crop&quality=75 960w">
            <source type="image/webp" media="(max-width: 600px)" srcset="${imgObject.src}?w=512&scale=both&mode=crop&quality=75 512w">
            <img class="glightbox" loading="lazy" src="${imgObject.src}?w=1920&scale=both&mode=crop&quality=75">
            </picture>
         </div>`;
   });

   galleryImageMarkup += `</div><div class="swiper-button-next"></div><div class="swiper-button-prev"></div><div class="swiper-pagination"></div>`;

   //append galerije u kontejner
   document.querySelector(".js-swiper-gallery").insertAdjacentHTML("afterbegin", galleryImageMarkup)
}

function renderSwiperArticle(moduleId) {
   const swiperStageMarkup = `<div class="swiper-wrapper"></div><div class="swiper-button-next"></div><div class="swiper-button-prev"></div>`;
   let swiperThumbMarkup = `<div class="swiper swiper-nav swiper-nav-${moduleId}">
                           <div class="swiper-wrapper">`;

   document.querySelector(".js-swiper-gallery").insertAdjacentHTML("afterbegin", swiperStageMarkup);

   //select edn items for further manipulation
   const ednItems = document.querySelectorAll(".js-swiper-gallery .edn-item");
   ednItems.forEach(item => {
      const imgThumbSrc = item.querySelector("img").src.split("?")[0];
      item.classList.add("swiper-slide");
      //append edn items to swiper wrapper
      document.querySelector(".swiper-stage .swiper-wrapper").appendChild(item);

      swiperThumbMarkup += `<div class="swiper-slide"><img src="${imgThumbSrc}?w=97&h=97&scale=both&mode=crop&quality=75"></div>`;
   });

   //remove old edn items container for swiper to work
   document.querySelector(".edn_505_article_list_wrapper").remove();

   swiperThumbMarkup += `</div></div>`;

   // Commented out to prevent swiperThumbMarkup from being shown in the markup
   // document.querySelector(".js-swiper-gallery").insertAdjacentHTML("afterend", swiperThumbMarkup);
}

function initLightbox() {

   //inicijalizacija lightboxa
   const lightbox = GLightbox({
      touchNavigation: true,
   })

   //link za download pojedine slike iz lightboxa
   const downloadImgBtnMarkup = `<a onclick="downloadImage(event)" class="download-img"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Pro 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2024 Fonticons, Inc.--><path d="M32 32l192 0 48 64 208 0 32 0 0 32 0 320 0 32-32 0L32 480 0 480l0-32L0 64 0 32l32 0zm240 96l-16 0-9.6-12.8L208 64 32 64l0 384 448 0 0-320-208 0zm0 80l0 121.4 52.7-52.7L336 265.4 358.6 288l-11.3 11.3-80 80L256 390.6l-11.3-11.3-80-80L153.4 288 176 265.4l11.3 11.3L240 329.4 240 208l0-16 32 0 0 16z"/></svg></a>`;

   //dodavanje linka za download slike kada je lightbox otvoren
   lightbox.on('open', () => {
      document.querySelectorAll(".gslide-media").forEach(slide => {
         //parent element mora biti relative kako bi se link nalazio na istom mjestu u odnosu na sliku
         slide.style.position = "relative";
         slide.insertAdjacentHTML("beforeend", downloadImgBtnMarkup);
      })
   });
}

function downloadImage(e) {
   const clickedLink = e.target.closest("a");
   //izvlačenje putanje do slike iz src atributa elementa
   const imgSource = clickedLink.previousElementSibling.src;
   //kreiranje linka sa adresom putanje do slike
   const link = document.createElement("a")
   link.href = imgSource;
   //zvlačenje naziva slike iz putanje
   link.download = imgSource.split('/').pop().split('?')[0];
   //dodavanje, klik i uklanjanje linka odmah nakon downloada
   document.body.appendChild(link);
   link.click();
   document.body.removeChild(link);
}
