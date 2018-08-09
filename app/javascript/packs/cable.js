// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
import ActionCable from 'actioncable';
//= require_self
//= require_tree ./channels

(function () {
  this.App || (this.App = {});
  this.App.cable = ActionCable.createConsumer();

}).call(window);