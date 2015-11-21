angular.module("app").controller "mainCtrl",  ($scope, $mdDialog) ->


  $scope.main_menu = [
    {name: "Design", id: 0},
    {name: "Hacking", id: 1},
    {name: "Math", id: 2},
    {name: "Template", id: 3},
    {name: "Money Ideas", id: 4}
  ]

  $scope.current_item = ""
  $scope.showGreeting = (item) ->
    $scope.current_item = item
    $mdDialog.show({
      clickOutsideToClose: true,
      scope: $scope,
      preserveScope: true,
      templateUrl: "menu_item_dialog.html",
      controller: "popup_ctrl"
   });
