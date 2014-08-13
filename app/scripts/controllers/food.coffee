'use strict'

@feedmeseymoreApp.controller 'FoodCtrl', ['$scope', '$location', '$http', '$stateParams', ($scope, $location, $http, $stateParams ) ->
  $scope.city = 'Los Angeles'
  console.log $stateParams.name
  $scope.map =
    center:
      latitude: 40.1451
      longitude: -99.6680
    zoom: 8
  $scope.marker =
    id: 0,
    coords:
      latitude: 40.1451,
      longitude: -99.6680
    options:
      draggable: false
  $scope.hasMoreVideos = false

  $http.get('https://api.tmade.co/v1/tags/6057b9cd-f1ec-4b43-a083-e5154ed7b9db/videos?api_key=webdevtest').success (data) ->
    console.log data[2]
    $scope.activeVideo = data[2]
    $http.get("#{$scope.activeVideo.venue._videosUrl}?api_key=webdevtest").success (data) ->
      if Object.keys(data).length > 1
        $scope.hasMoreVideos = true
        console.log data
]


