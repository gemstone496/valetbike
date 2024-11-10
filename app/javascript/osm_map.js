/*
Base for this code pulled from https://stackoverflow.com/questions/925164/openstreetmap-embedding-map-in-webpage-like-google-maps
Answer by user totymedli
*/

const northamptonLat = '42.328674'; // what it says on the tag
const northamptonLng = '-72.664658'; // rough center of northampton

/*
initializes the map for future use
TODO
 - figure out the tiling thing and how to get an actual image rendered
*/
function mapInit(){
    // Where you want to render the map.
    var element = document.getElementById("osm-map");

    // Create Leaflet map on map element.
    var map = L.map(element);

    // Add OSM tile layer to the Leaflet map.
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    // Target's GPS coordinates.
    var target = L.latLng(northamptonLat, northamptonLng);

    // Set map's center to target with zoom 14.
    map.setView(target, 14); // consider changing zoom

    // Place a marker on the location.
    L.marker(target).addTo(map);

    document.element.map = map;
}

/*
adds a marker to the leaflet
TODO
 - hoping that the map var is getting set correctly
 - add a popup to the marker to link to the station page
*/
function addMarker(lat, lng) {
    var map = document.getElementById('osm-map').map;

    // Target's GPS coordinates.
    var target = L.latLng(lat, lng);

    // Place a marker on the location.
    L.marker(target).addTo(map);
}