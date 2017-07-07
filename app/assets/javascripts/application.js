//= require jquery
//= require jquery-ui
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/position
//= require jquery_ujs
//= require tinymce-jquery
//= require tinymce
//= require_self
//= require_tree .


$(document).ready(function(){

    $( "#searchText" ).autocomplete(
        {
            source:"/search/index",
            select: function( event, ui ) {
                $( "#searchText" ).val( ui.item._source.title );
                $( "#results").empty();
                $( "#results" ).append( '<a href= '+"articles"+'/'+ui.item._id+ '>' +ui.item._source.title+'</a>' );
                window.location.href = "/articles/"+ui.item._id;
                return false;
            }

        }).data( "ui-autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li></li>" )
            .data( "item.autocomplete", item )
            .append( "<a>" + item._source.title + "</a>" )
            .appendTo( ul );
    };
});
function myMap() {
var mapOptions = {
    center: new google.maps.LatLng(20.349150, 85.807660),
    zoom: 10,
    mapTypeId: google.maps.MapTypeId.ROADMAP
}
var map = new google.maps.Map(document.getElementById("map"), mapOptions);
// Creating a marker and positioning it on the map  
    var marker = new google.maps.Marker({  
      position: new google.maps.LatLng(20.349150, 85.807660),  
      map: map  
    });
}