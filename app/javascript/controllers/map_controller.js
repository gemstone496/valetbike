import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'

export default class extends Controller {
  static values = {
    lat: Array,
    long: Array,
    name: Array,
    id: Array
  };

  connect(){
    console.log("Controller Connected!!");

    this.element.style.height = "400px"; // pulled this out here ig? should likely be in a css script
    
    this.createMap();

    // Add the markers for each station
    for (let i = 0; i < this.idValue.length; i++)
      {
        console.log("loading item " + i);
        let lat = this.latValue[i];
        let long = this.longValue[i];
        let name = this.nameValue[i];
        if (lat !== null && long !== null && name !== null)
        {
            this.addMarker(lat, long, name);
        }
      }
  }
  
  /* initializes the map for future use */
  createMap() {
    // Create Leaflet map on map element.
    this.map = L.map(this.element);
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);
    
    // Set map's center to target.
    const northamptonLat = '42.328674'; // what it says on the tag
    const northamptonLng = '-72.646'; // rough center of northampton
    const center = L.latLng(northamptonLat, northamptonLng);
    this.map.setView(center, 14); // consider changing zoom

    console.log("Map Loaded!!");
  }

  /* adds a marker to the leaflet
  TODO
    - link popup to the station page */
  addMarker(lat, long, name) {
    // Place a marker on the location.
    L.marker([lat, long])
      .addTo(this.map)
      .bindPopup(name);
  }
}