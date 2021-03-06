/*global google */

const GoogleMap = function(elementId) {
  let self = this;
  self.map = new google.maps.Map(document.getElementById(elementId), {
    zoom: 12,
    mapTypeId: "hybrid"
  });
  self.trackPaths = [];
  self.setPath = function(points, options = {}) {
    let trackOptions = Object.assign(
      {
        path: points,
        geodesic: true,
        strokeColor: "red",
        strokeOpacity: 1.0,
        strokeWeight: 2
      },
      options
    );
    let center = points[Math.round(points.length / 2)];
    let trackPath = new google.maps.Polyline(trackOptions);

    self.map.setCenter(center);
    trackPath.setMap(self.map);
    self.trackPaths.push(trackPath);
  };
  self.reset = function() {
    self.trackPaths.forEach(function(el) {
      el.setMap(null);
    });
    self.trackPaths = [];
  };
};
