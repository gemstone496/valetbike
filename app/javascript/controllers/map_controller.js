import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'

export default class extends Controller {
  static targets = [ "container" ];
  static values = {
    lat: Array,
    long: Array,
    name: Array,
    id: Array
  };

  connect(){
    console.log("Controller Connected!!");

    this.containerTarget.style.height = "400px"; // pulled this out here ig? should likely be in a css script
    
    this.createMap();

    let purpleIcon = '/images/map-marker.png';

    // Add the markers for each station
    for (let i = 0; i < this.idValue.length; i++) {
      console.log("loading item " + i);
      let lat = this.latValue[i];
      let long = this.longValue[i];
      let name = this.nameValue[i];
      let id = this.idValue[i];
      if (lat !== null && long !== null && name !== null) {
          this.addMarker(lat, long, name, id, purpleIcon);
      }
    }

    // Add a you-are-here
    let uLat = this.userCoordValue[0]; // user latitude
    let uLong = this.userCoordValue[1]; // user longitude
    let pfpath = this.pfpValue; // ProFile pic PATH

    console.log("Entering from [" + uLat + ", " + uLong + "]");
    console.log("User profile from `" + pfpath + "`");

    if (uLat !== null && uLong) {
      this.addMarker(uLat, uLong, null, null, pfpath);
    }
  }
  
  /* initializes the map for future use */
  createMap() {
    // Create Leaflet map on map element.
    this.map = L.map(this.containerTarget);
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);

    // Add a you-are-here
    let uCoords = this.userCoordValue; // user lat long
    let pfpath = this.pfpValue; // ProFile pic PATH

    if (uCoords == null) {
      uCoords = ['42.3255', '-72.646']; // northampton center
    }

    this.addMarker(uCoords[0], uCoords[1], null, null, pfpath);
    
    console.log("Entering from [" + uCoords[0] + ", " + uCoords[1] + "]");
    console.log("User profile from `" + pfpath + "`");
    console.log("Map Loaded!!");
    
    // Set map's center.
    const center = L.latLng(uCoords[0], uCoords[1]);
    this.map.setView(center, 13.5); // consider changing zoom

    console.log("Map Loaded!!");
  }

  /* adds a marker to the leaflet */
  addMarker(lat, long, name, id, iconPath) {

    let icon = L.icon({
      iconUrl: iconPath,
      iconSize:     [30, 40] // size of the icon
    });

        // Place a marker on the location with custom icon
    let marker = L.marker([lat, long], {icon: icon})
        .addTo(this.map);

    if (id !== null){ // here markers
      marker.bindPopup(this.buttonTo(name, id));
    }
  }

  /* helper method to get the button_to link to place in the popup */
  buttonTo(name, id) {
    return `<form class='button_to' method='get' action='/stations/${id}'> 
      <button class='mt-3 custom-btn btn-outline' type='submit'>${name}
      </button></form>`
  }
}