$(window).bind('load resize turbolinks:load', () => {
  $('img[usemap]').maphilight();
  $('map').imageMapResize();
});
