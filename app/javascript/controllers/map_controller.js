import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [-74.5, 40],
      zoom: 4
    });
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

    #fitMapToMarkers(){
      const bounds = new mapboxgl.LngLatBounds()
      this.markersValue.forEach((marker) => {
        bounds.extend([ marker.lng, marker.lat]);
      });
      this.map.fitBounds(bounds, {padding: 50, duration: 10, maxZoom: 13})
    }


    #addMarkersToMap() {
      this.markersValue.forEach((marker) => {
        const customMarker = document.createElement("div")
        customMarker.style.height = "30px"
        customMarker.style.width = "27px"
        customMarker.style.backgroundImage = `url(${marker.image_url})`
        customMarker.style.backgroundSize = "contain"
        new mapboxgl.Marker(customMarker)
          // .setLngLat([ marker.lat, marker.lng ])
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(this.map)
    })
  }
}
