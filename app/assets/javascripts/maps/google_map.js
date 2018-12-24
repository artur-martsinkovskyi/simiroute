/*global google */

const GoogleMap = function(elementId) {
  let self = this;
  self.map = new google.maps.Map(document.getElementById(elementId), {
    zoom: 12,
    mapTypeId: "hybrid"
  });

  self.setPath = function(points) {
    let center = points[Math.round(points.length / 2)];
    let trackPath = new google.maps.Polyline({
      path: points,
      geodesic: true,
      strokeColor: "#FF0000",
      strokeOpacity: 1.0,
      strokeWeight: 2
    });

    trackPath.setMap(self.map);
    self.map.setCenter(center);
  };
};
