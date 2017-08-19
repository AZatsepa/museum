# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css,
# and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w[comments.scss
                                                 comparising.scss
                                                 pages.scss
                                                 posts.scss
                                                 reset.css.scss
                                                 results.scss
                                                 style.css.scss
                                                 users.scss
                                                 modernizr.js
                                                 jquery-2.1.1.js
                                                 jquery.mobile.custom.min.js
                                                 jquery.imagemapster.js
                                                 mapshower.js
                                                 main.js]
