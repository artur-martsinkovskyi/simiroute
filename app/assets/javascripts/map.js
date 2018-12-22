document.addEventListener('DOMContentLoaded', function() {
  initMap();
}, false);



function initMap() {
  var map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 12,
    center: gon.points[0],
    mapTypeId: 'terrain'
  });

  var trackPath = new google.maps.Polyline({
    path: gon.points,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });

  trackPath.setMap(map);
}



