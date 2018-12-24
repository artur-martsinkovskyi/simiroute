/* global GoogleMap */

document.addEventListener("DOMContentLoaded", function() {
  let googleMap = new GoogleMap("map-canvas");
  let opts = {
    method: "GET",
    headers: {}
  };

  fetch("/api/v1/" + window.location.pathname, opts).then(function (response) {
    return response.json();
  }).then(function (body) {
    googleMap.setPath(body["points"]);
  });
}, false);


