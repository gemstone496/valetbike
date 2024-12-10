import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'
export default class extends Controller {
  static targets = [ "container" ];
  static values = {
    lat: Array,
    long: Array,
    name: Array,
    identifier: Array,
    id: Array,
    address: Array,
    bike: Array,
    userid: Boolean,
    tripid: Boolean,
    iduser: String,
    idtrip: String,
    pfp: {type: String, default: '/images/fallback/default.png'}
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
      let identifier = this.identifierValue[i];
      let id = this.idValue[i];
      let address = this.addressValue[i];
      let bike = this.bikeValue[i];
      if (lat !== null && long !== null && name !== null) {
        this.addMarker(lat, long, purpleIcon, name, identifier, id, address, bike);
      }
    }

    // Add a you-are-here
    navigator.geolocation.getCurrentPosition(
      (position) => { this.locationSuccess(position); },
      (error) => { this.defaultZoom(); }  // show at bass hall
    );
  }

  /* initializes the map for future use */
  createMap() {
    // Create Leaflet map on map element.
    this.map = L.map(this.containerTarget);
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);

    this.defaultZoom();

    console.log("User profile from `" + this.pfpValue + "`");

    console.log("Map Loaded!!");
  }

  /* what to do if the user allows location access */
  locationSuccess(position) {
    let pfpath = this.pfpValue; // ProFile pic PATH
    let lat = position.coords.latitude;
    let long = position.coords.longitude;
    this.addMarker(lat, long, pfpath, null, null, null, null, null);

    // set as center
    const center = L.latLng(lat, long);
    this.map.setView(center, 13.5); // consider changing zoom
  }

  /* */
  defaultZoom() {
    const northamptonLat = '42.3172951'; // what it says on the tag
    const northamptonLng = '-72.6386734'; // bass hall hardcoded values :)
    
    // set as center
    const center = L.latLng(northamptonLat, northamptonLng);
    this.map.setView(center, 13.5); // consider changing zoom
  }

  /* adds a marker to the leaflet */
  addMarker(lat, long, iconPath, name, identifier, id, address, bike) {

    let size = id === null ? [30, 30] : [30, 40]; // size of the icon

    let icon = L.icon({
      iconUrl: iconPath,
      iconSize: size
    });

        // Place a marker on the location with custom icon
    let marker = L.marker([lat.toString(), long.toString()], {icon: icon}).addTo(this.map);
    if (id !== null) { // here markers
      marker.bindPopup(this.popupContent(name, identifier, id, address, bike));
    }
  }

/* helper method to get the button_to link to place in the popup */

/*  popupContent(name, id, address, bike) {
    return `
    <div>
     <div class="title">  Station ${id}: ${name} </div> <br>
    <div class="body"> ${address} </div>
    <div class="body"> ${bike} available bikes </div>
    <form class='button_to' method='get' action='/stations/${id}'>
        <button class='mt-3 custom-btn btn-outline' type='submit'>Reserve a Bike</button>
      </form>
      </div>
  `;
  }*/
  popupContent(name, identifier, id, address, bike) {
    const availableBikes = bike;
    const user = this.useridValue;
    const trip = this.tripidValue;
    const user_id = this.iduserValue;
    const idtrip = this.idtripValue;
    let buttonContent = '';

      if (!user) {
        buttonContent = `
        <button onclick="reserve_alert('Please log in to reserve a bike!')" 
        class="mt-3 custom-btn btn-invalid">Reserve Bike</button>
      `;

      } else if (availableBikes == 0 && !trip) {
        buttonContent = `
        <button onclick="reserve_alert('No bikes at this station!')" 
        class="mt-3 custom-btn btn-invalid">Reserve Bike</button>
      `;
      } else if (!trip) {
      buttonContent = `

        <a href="/trips/new?station_id=${id}&user_id=${user_id}" 
        class="mt-3 custom-btn btn-fill" 
        style="display: inline-block; text-decoration: none; color: inherit;" 
        style="color: unset; text-decoration: unset;">
       
      Reserve Bike
    </a>
  
      `;
    } else if (trip) {
        buttonContent = `
          <a href="end_confirm?id=${idtrip}&end_station_id=${id}&user_id=${user_id}"
                 class="mt-3 custom-btn btn-fill" 
                    style="display: inline-block; text-decoration: none; color: inherit;" 
                    style="color: unset; text-decoration: unset;">
          Return Bike Here
          </a>
<!--   <button id="return-btn" class="mt-3 custom-btn btn-fill" data-station-id=id>Return Bike Here</button>-->
      `;
    }
    return `
      <div>
        <div class="title_popup">Station ${identifier}: ${name}</div>
        <div class="body">${address}</div>
        <div class="body">${availableBikes} available bike(s)</div>
        ${buttonContent}
      </div>
      <script>
        function reserve_alert(message) {
          alert(message);
        }
      </script>
    `;
  }

}