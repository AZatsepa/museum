const { environment } = require('@rails/webpacker');
const coffee = require('./loaders/coffee');
const vue = require('./loaders/vue');


environment.loaders.append('coffee', coffee);
const webpack = require('webpack');

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
  jst: 'jst',
}));

environment.loaders.append('vue', vue);
module.exports = environment;
