app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'templates' ])

angular.element(document).ready () ->
  angular.bootstrap(document, ["app"]);
