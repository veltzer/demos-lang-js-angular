(function() {
  'use strict';

  angular
      .module('MyApp',['ngMaterial', 'ngMessages'])
      .controller('AppCtrl', AppCtrl)
      .config(function($mdThemingProvider, $mdIconProvider){
		/*
		$mdThemingProvider.theme('default')
			//.primaryPalette('white')
			//.backgroundPalette('indigo')
			//.accentPalette('yellow')
			.dark();
		*/
      });

  function AppCtrl ( $scope ) {
    $scope.data = {
      selectedIndex: 0,
      secondLocked:  true,
      secondLabel:   "Item Two",
      bottom:        false
    };
    $scope.next = function() {
      $scope.data.selectedIndex = Math.min($scope.data.selectedIndex + 1, 2) ;
    };
    $scope.previous = function() {
      $scope.data.selectedIndex = Math.max($scope.data.selectedIndex - 1, 0);
    };
  }
})();
