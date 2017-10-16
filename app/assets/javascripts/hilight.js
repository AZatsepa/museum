var mapHilight = function() {
    $('img[usemap]').maphilight();
};

$(document).ready(mapHilight);
$(document).on('turbolinks:load', mapHilight);
