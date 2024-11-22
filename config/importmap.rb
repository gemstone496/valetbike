# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "leaflet", to: "https://ga.jspm.io/npm:leaflet@1.7.1/dist/leaflet-src.js"
pin "leaflet-provider", to: "https://ga.jspm.io/npm:leaflet-providers@1.13.0/leaflet-providers.js"
pin "geocoders", to: "https://unpkg.com/leaflet-geosearch@latest/dist/bundle.min.js"