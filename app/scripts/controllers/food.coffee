'use strict'

@feedmeseymoreApp.controller 'FoodCtrl', ['$scope', '$location', '$http', ($scope, $location, $http, $log ) ->
  $scope.city = 'Los Angeles'
  console.log $scope
  $http.get('https://api.tmade.co/v1/tags/6057b9cd-f1ec-4b43-a083-e5154ed7b9db/videos?api_key=webdevtest').success (data) ->
    console.log data
]


