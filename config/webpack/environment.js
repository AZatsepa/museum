const { environment } = require('@rails/webpacker');
const coffee = require('./loaders/coffee');

environment.loaders.append('coffee', coffee);
const webpack = require('webpack');

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
  jst: 'jst',
}));

module.exports = environment;
