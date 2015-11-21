angular.module("app").controller "popup_ctrl",  ($scope, $mdDialog) ->


  $scope.actions =
    save: () ->
      $mdDialog.hide();
    hide: () ->
      $mdDialog.hide();
    remove: () ->
      $mdDialog.hide();
      _.remove($scope.main_menu, {id: $scope.current_item.id})
  $scope.closeDialog = () ->
    $mdDialog.hide();

  $scope.remove_item = () ->
