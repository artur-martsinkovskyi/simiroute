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

    function setPath(id, color) {
      return fetch("/api/v1/tracks/" + id + "/points/", opts)
        .then(function(response) {
          return response.json();
        });
    }

    function setComparisonPath(trackId1, trackId2, color) {
      return fetch(
        "/api/v1/tracks/compare?track1=" + trackId1 + "&track2=" + trackId2,
        opts
      ).then(function(response) {
        return response.json();
      });
    }


    let similarityHeading = document.getElementById("similarity");
    let compareTrackButton = document.getElementById("compare-track");
    let selectTrack1 = document.getElementById("select-track1");
    let selectTrack2 = document.getElementById("select-track2");


    function setupComparisonPaths() {
      googleMap.reset();
      let trackId1 = selectTrack1.value;
      let trackId2 = selectTrack2.value;
      Promise.all(
        [
          setPath(trackId1),
          setPath(trackId2),
          setComparisonPath(trackId1, trackId2)
        ]
      ).then(
        function(result) {
          let [firstTrack, secondTrack, comparisonResult] = result;

          googleMap.setPath(
            firstTrack,
            {
              strokeColor: 'blue',
              strokeWeight: 3
            }
          );
          googleMap.setPath(
            secondTrack,
            {
              strokeColor: 'yellow',
              strokeWeight: 4
            }
          );
          googleMap.setPath(comparisonResult["points"], {
            strokeColor: 'red',
            strokeWeight: 2
          });
          similarityHeading.innerHTML =
            comparisonResult["similarity"][0] +
            "% and " +
            comparisonResult["similarity"][1] +
            "% for each track accordingly.";
        });
    }

    setupComparisonPaths();

    compareTrackButton.addEventListener("click", setupComparisonPaths);
  },
  false
);
