angular.module("app").controller "item_viewer",  ($scope, $mdDialog) ->



  $scope.actions =
    save: () ->
      if angular.isUndefined($scope.current_item.parent)
        $scope.items.post({name: $scope.current_item.name, parent: $scope.current_parent, content: $scope.current_item.content}).then (data) ->
          $scope.items.push data
      else
        $scope.current_item.save()
      $mdDialog.hide();
    hide: () ->
      $mdDialog.hide();
    remove: () ->
      $mdDialog.hide();
      if !angular.isUndefined($scope.current_item.parent)
        $scope.current_item.remove()
        _.remove($scope.items, {id: $scope.current_item.id})
