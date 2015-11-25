angular.module("app").controller "mainCtrl",  ($scope, $mdDialog, Restangular) ->


  $scope.main_menu = []

  $scope.get_page = () ->
    Restangular.all('items').getList({parent: $scope.current_parent}).then (data) ->
      console.log data
      $scope.items = data

  Restangular.all('cats').getList().then (data) ->
    $scope.main_menu = data
    $scope.main_menu[0].active = true
    $scope.current_parent = $scope.main_menu[0].id
    $scope.get_page()

  $scope.set_parent = (item) ->
    for i in $scope.main_menu
      i.active = false
    item.active = true
    $scope.current_parent = item.id
    $scope.get_page()


  $scope.new_element = () ->
    $scope.current_item = {}
    $mdDialog.show({
      clickOutsideToClose: true,
      scope: $scope,
      preserveScope: true,
      templateUrl: "item_viewer.html",
      controller: "item_viewer"
   });

  $scope.input_newname = (event) ->
    if event.keyCode == 13
      $scope.new_item = false
      $scope.main_menu.post({name: $scope.newitem_name}).then (data) ->
        $scope.main_menu.push(data)
        $scope.newitem_name = ""


  $scope.blurname = () ->
    console.log 'hacking stuff'
    $scope.new_item = false
    $scope.newitem_name = ""

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

  $scope.item_viewer = (item) ->
   $scope.current_item = item
   $mdDialog.show({
     clickOutsideToClose: true,
     scope: $scope,
     preserveScope: true,
     templateUrl: "item_viewer.html",
     controller: "item_viewer"
  });
