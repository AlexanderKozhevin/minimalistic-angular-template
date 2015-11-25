app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'templates', 'ngAnimate', 'ngMaterial', 'ngMdIcons',  'restangular'])


app.config (RestangularProvider) ->
  RestangularProvider.setBaseUrl('http://localhost:1337/api')


angular.element(document).ready () ->
  angular.bootstrap(document, ["app"]);
