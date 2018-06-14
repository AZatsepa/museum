const mapHilight = () => {
  $('img[usemap]').maphilight();
  $('map').imageMapResize();
};

$(window).bind('load resize turbolinks:load', () => {
  mapHilight();
});
