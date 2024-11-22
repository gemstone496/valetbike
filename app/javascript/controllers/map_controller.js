import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'

export default class extends Controller {
  static targets = [ 'lats', 'longs', 'names', 'ids' ];

  connect(){
    console.log("Map Connected!!");

    const northamptonLat = '42.328674'; // what it says on the tag
    const northamptonLng = '-72.646'; // rough center of northampton
    const center = L.latLng(northamptonLat, northamptonLng);

    this.element.style.height = "400px"; // pulled this out here ig? should likely be in a css script
    
    /* adds a marker to the leaflet
      TODO
        - hoping that the map var is getting set correctly
        - add a popup to the marker to link to the station page */
    const addMarker = (lat, lng, name) => {
      // Target's GPS coordinates.
      var target = L.latLng(lat, lng);

      // Place a marker on the location.
      L.marker(target).addTo(this.map).bindPopup(name);    
      
      // Set map's center to target with zoom 14.
      this.map.setView(center, 14); // consider changing zoom
    };

    /* initializes the map for future use */
    const mapInit = () => {
      // Create Leaflet map on map element.
      this.map = L.map(this.element);
      // Add OSM tile layer to the Leaflet map.
      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(this.map);

      let lats = this.latsTarget.dataset.source;
      let longs = this.longsTarget.dataset.source;
      let names = this.namesTarget.dataset.source;
      let ids = this.idsTarget.dataset.source;

      // Convert to objects
      lats = JSON.parse(lats);
      longs = JSON.parse(longs);
      names = JSON.parse(names);
      ids = JSON.parse(ids);

      // Add the markers for each station
      for (let i = 0; i < lats.length; i++)
      {
        if (lats[i] !== null && longs[i] !== null && names[i] !== null)
        {
            addMarker(lats[i], longs[i], names[i]);
        }
      }
      
      // Set map's center to target with zoom 14.
      this.map.setView(center, 14); // consider changing zoom
    };
    
    mapInit();
  }
}

/*
Base for this code pulled from https://stackoverflow.com/questions/925164/openstreetmap-embedding-map-in-webpage-like-google-maps
Answer by user totymedli
*/


function addMarker(map, lat, lng) {
}