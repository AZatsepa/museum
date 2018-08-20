const { environment } = require('@rails/webpacker');
const coffee = require('./loaders/coffee');
const vue = require('./loaders/vue');
const erb = require('./loaders/erb');
const customConfig = require('./custom');

environment.config.merge(customConfig);
environment.loaders.append('coffee', coffee);
const webpack = require('webpack');

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
  jst: 'jst',
}));

environment.loaders.append('vue', vue);
environment.loaders.append('erb', erb);

module.exports = environment;
