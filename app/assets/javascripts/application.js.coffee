#= require jquery/jquery
#= require hamlcoffee
#= require bootstrap
#= require angular/angular
#= require angular-resource/angular-resource
#= require angular-ui-router/release/angular-ui-router
#= require angular-ui-utils/modules/event/event
#= require angular-ui-map/src/map
#= require app/main
#= require_tree ./config
#= require_tree ./app/filters
#= require_tree ./app/resources
#= require_tree ./app/controllers
#= require_tree ./app/directives
#= require_self

window.onGoogleReady = ->
  angular.bootstrap(document.getElementById("map"), ['familyMe']);

window.onload = ->
  script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAE_FKae6SYVvdyddYHWdwUPs-8mMJmqqs&sensor=false&callback=onGoogleReady';
  document.body.appendChild(script);
