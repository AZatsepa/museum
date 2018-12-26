/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
// require('imports-loader?this=>window!jquery-mobile/dist/jquery.mobile.js');
import 'bootstrap';
import 'jquery';
import 'jquery-ui';
import 'jquery-ujs';
import Turbolinks from 'turbolinks';
import 'datatables.net';
import 'babel-polyfill';

import '../images/1782.png';
import '../images/1782_white.jpg';
import '../images/1943.png';
import '../images/2017.png';
import '../images/background.jpg';
import '../images/noavatar.png';
import '../src/application.scss';

import './cable';
import './vue_settings';
import './imageMapResizer';
import './jquery.maphilight';
import './markitup';
import './localizations';
import './main';
import './markitup_html';
import './posts';
import './hilight';
import './admin/comments';
import './admin/users';

Turbolinks.start();

window.I18n = require('i18n-js');
