/* global GoogleMap */

function getRandomColor() {
  let letters = "0123456789ABCDEF";
  let color = "#";
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

document.addEventListener(
  "DOMContentLoaded",
  function() {
    let googleMap = new GoogleMap("map-canvas");
    let opts = {
      method: "GET",
      headers: {}
    };
    let similarityHeading = document.getElementById("similarity");

    function setPath(id, color) {
      fetch("/api/v1/tracks/" + id + "/points/for_map", opts)
        .then(function(response) {
          return response.json();
        })
        .then(function(body) {
          googleMap.setPath(body, color || getRandomColor());
        });
    }

    function setComparisonPath(trackId1, trackId2, color) {
      fetch(
        "/api/v1/tracks/compare?track1=" + trackId1 + "&track2=" + trackId2,
        opts
      )
        .then(function(response) {
          return response.json();
        })
        .then(function(body) {
          googleMap.setPath(body["points"], color || getRandomColor());
          similarityHeading.innerHTML =
            body["similarity"][0] +
            "% and " +
            body["similarity"][1] +
            "% for each track accordingly.";
        });
    }

    let compareTrackButton = document.getElementById("compare-track");
    let selectTrack1 = document.getElementById("select-track1");
    let selectTrack2 = document.getElementById("select-track2");
    compareTrackButton.addEventListener("click", function(e) {
      googleMap.reset();
      let trackId1 = selectTrack1.value;
      let trackId2 = selectTrack2.value;
      setPath(trackId1, "blue");
      setPath(trackId2, "yellow");
      setComparisonPath(trackId1, trackId2, "red");
    });
  },
  false
);
