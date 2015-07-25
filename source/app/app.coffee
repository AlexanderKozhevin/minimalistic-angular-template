app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'templates', 'ngAnimate', 'ngMaterial', 'ngMdIcons' ])

angular.element(document).ready () ->
  angular.bootstrap(document, ["app"]);
