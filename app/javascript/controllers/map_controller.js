import { Controller } from "@hotwired/stimulus"
import L from 'leaflet'

export default class extends Controller {
  static targets = [ "container" ];
  static values = {
    lat: Array,
    long: Array,
    name: Array,
    id: Array,
    address: Array,
    bike: Array,
    userid: Boolean,
    tripid: Boolean,
    iduser: String,
    idtrip: String,
    bikeid: String
  };

  connect(){
    console.log("Controller Connected!!");

    this.containerTarget.style.height = "400px"; // pulled this out here ig? should likely be in a css script
    
    this.createMap();

    // Add the markers for each station
    for (let i = 0; i < this.idValue.length; i++)
      {
        console.log("loading item " + i);
        let lat = this.latValue[i];
        let long = this.longValue[i];
        let name = this.nameValue[i];
        let id = this.idValue[i];
        let address = this.addressValue[i];
        let bike = this.bikeValue[i];
        if (lat !== null && long !== null && name !== null)
        {
            this.addMarker(lat, long, name, id, address, bike);
        }
      }
  }
  
  /* initializes the map for future use */
  createMap() {
    // Create Leaflet map on map element.
    this.map = L.map(this.containerTarget);
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);
    
    // Set map's center to target.
    const northamptonLat = '42.3255'; // what it says on the tag
    const northamptonLng = '-72.646'; // rough center of northampton
    const center = L.latLng(northamptonLat, northamptonLng);
    this.map.setView(center, 13.5); // consider changing zoom

    console.log("Map Loaded!!");
  }

  /* adds a marker to the leaflet
  TODO
    - link popup to the station page */
  addMarker(lat, long, name, id, address, bike) {

    var purpleIcon = L.icon({
      iconUrl: '/images/map-marker.png',
      iconSize:     [30, 40] // size of the icon
    });

        // Place a marker on the location with custom icon
    L.marker([lat, long], {icon: purpleIcon})
        .addTo(this.map)
        .bindPopup(this.popupContent(name, id, address, bike));
  }
/*  addMarker(lat, long, name, id) {
    // Place a marker on the location.
    L.marker([lat, long])
      .addTo(this.map)
      .bindPopup(this.buttonTo(name, id));
  }*/

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
  popupContent(name, id, address, bike) {
    const availableBikes = bike;
    const user = this.useridValue;
    const trip = this.tripidValue;
    const user_id = this.iduserValue;
    const trip_id = this.idtripValue;
    const bike_id = this.bikeidValue;
    let buttonContent = '';
    if (user && !trip) {
      buttonContent = `
        <form method="get" 
        action="/trips/new?bike_id=${bike_id}&station_id=${id}&user_id=${user_id}">
          <button class="mt-3 custom-btn btn-fill" type="submit">Reserve Bike</button>
        </form>
      `;

    } else if (trip) {
      buttonContent = `
        <form method="get" 
        action="/end_confirm?trip_id=${trip_id}&end_station_id=${id}">
          <button class="mt-3 custom-btn btn-fill" 
          type="submit">Return Bike Here</button>
        </form>

      `;
    } else if (!user) {
      buttonContent = `
        <button onclick="reserve_alert('Please log in to reserve a bike!')" class="mt-3 custom-btn btn-invalid">Reserve Bike</button>
      `;
    } else if (availableBikes == 0 && !trip) {
      buttonContent = `
        <button onclick="reserve_alert('No bikes at this station!')" class="mt-3 custom-btn btn-invalid">Reserve Bike</button>
      `;
    }
    return `
      <div>
        <div class="title">Station ${id}: ${name}</div><br/>
        <div class="body">${address}</div>
        <div class="body">${availableBikes} available bikes</div>
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