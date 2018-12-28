const { environment } = require('@rails/webpacker');
const webpack = require('webpack');
const coffee = require('./loaders/coffee');
const vue = require('./loaders/vue');
const customConfig = require('./custom');

environment.config.merge(customConfig);
environment.loaders.append('coffee', coffee);
environment.loaders.append('vue', vue);

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
  jst: 'jst',
}));

module.exports = environment;
