const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader')
const webpack = require('webpack');
const vue = require('./loaders/vue')
const customConfig = require('./custom');

environment.config.merge(customConfig);

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default'],
  jst: 'jst',
}));

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
module.exports = environment;
