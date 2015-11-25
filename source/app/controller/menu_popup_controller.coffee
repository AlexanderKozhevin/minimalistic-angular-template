angular.module("app").controller "popup_ctrl",  ($scope, $mdDialog) ->


  $scope.actions =
    save: () ->
      $mdDialog.hide();
      $scope.current_item.save()
    hide: () ->
      $mdDialog.hide();
    remove: () ->
      $mdDialog.hide();
      $scope.current_item.remove()
      _.remove($scope.main_menu, {id: $scope.current_item.id})
