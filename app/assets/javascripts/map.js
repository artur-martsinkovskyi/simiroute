function initMap(points) {
  var map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 12,
    center: points[0],
    mapTypeId: "terrain"
  });

  var trackPath = new google.maps.Polyline({
    path: points,
    geodesic: true,
    strokeColor: "#FF0000",
    strokeOpacity: 1.0,
    strokeWeight: 2
  });

  trackPath.setMap(map);
}

document.addEventListener("DOMContentLoaded", function() {
  var opts = {
    method: "GET",
    headers: {}
  };

  fetch("/api/v1/" + window.location.pathname, opts).then(function (response) {
    return response.json();
  }).then(function (body) {
    initMap(body["points"]);
  });
}, false);


