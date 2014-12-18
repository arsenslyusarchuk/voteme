// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require angular
//= require turbolinks
//= require angular-route
//= require angular-resource
//= require angular-animate
//= require angular-touch
//= require angular-ui-bootstrap-tpls
//= require infinite-scroll
//= require angucomplete
//= require app
//= require_tree ./angular

$(document).on('ready page:load', function(arguments) {
  // if (window.location.href.indexOf('#_=_') > 0) {
  //   window.location = window.location.href.replace(/#.*/, '');
  // }
  setTimeout(function(){
    $('.alert').slideUp(500);
  }, 2000);
  angular.bootstrap(document.body, ['voteMe']);
});


