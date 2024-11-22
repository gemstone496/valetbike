# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "leaflet" # @1.9.4
pin "geocoder" # @0.2.3
pin "leaflet-providers" # @2.0.0
