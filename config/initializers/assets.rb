# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( form.css )

# uhh so rails told me to add all these inexplicably but it works now so...
Rails.application.config.assets.precompile += %w( tailwind.css )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( controllers/hello_controller.js )
Rails.application.config.assets.precompile += %w( controllers/index.js )
Rails.application.config.assets.precompile += %w( leaflet.js )
Rails.application.config.assets.precompile += %w( leaflet-providers.js )
Rails.application.config.assets.precompile += %w( geocoder.js )
Rails.application.config.assets.precompile += %w( controllers/map_controller.js )
