var mapHilight = function() {
    $('img[usemap]').maphilight();
    $('map').imageMapResize();
};

$(window).bind("load resize turbolinks:load",function(e){
    mapHilight();
});
