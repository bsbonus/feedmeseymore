'use strict'

@feedmeseymoreApp.controller 'FoodCtrl', ['$scope', '$location', '$http', '$stateParams', '$sce', 'NearbyVids', '$filter', ($scope, $location, $http, $stateParams, $sce, NearbyVids, $filter ) ->
  $scope.city =
    name: 'Los Angeles, CA'
  $scope.tagHasVideos = false
  $scope.tagName = $stateParams.name
  $scope.matchingVideos = []
  $scope.url = $sce.trustAsResourceUrl("https://d2aiijjnretqc1.cloudfront.net/cv/ez/cvezjiaxqwkpmfhr9ptisq/v1/360-600.mp4?")
  $scope.videoPoster = "/images/testimg2.jpg"
  $scope.hasMoreVideos = false
  $scope.nearbyVideos = [[]]
  $scope.venueVideos = []

  NearbyVids.getNearbyVideos(34.1111623, -118.2793132)
    .success (data) ->
      for vid in data
        $scope.matchingVideos.push vid
      $scope.nearbyVideos = $filter('groupBy')(data)
    .error (err, result) ->
      $scope.nearbyVids = false

  $scope.coords =
    lat: 34.111063
    long: -118.27938379999998
  $scope.map =
      center:
        latitude: $scope.coords.lat
        longitude: $scope.coords.long
      zoom: 12
  $scope.marker =
    id: 0,
    coords:
      latitude: 34.111063,
      longitude: -118.27938379999998
    options:
      draggable: false

  $scope.setCoords = (position)->
    $scope.coords = position.coords

  $scope.getLocation = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition($scope.setCoords)

  $scope.setActiveVideo = (id) ->
    for vid in $scope.matchingVideos
      if vid._id is id
        $scope.activeVideo = vid
        $scope.activeUrl = vid.video.url

  $scope.trustVideo = (url) ->
    return $sce.trustAsResourceUrl url

  $http.get("https://api.tmade.co/v1/tags/#{$stateParams.name}/videos?api_key=webdevtest").success (data) ->
    for vid in data
      if vid.venue isnt undefined and vid.venue.geoName is $scope.city
        vid['adjustedThumbUrl'] = vid.thumbnail.url.replace(/dg14fekn8y2fu/, 'd2inek5pdajgud')
        $scope.tagHasVideos = true
        $scope.matchingVideos.push vid

    if $scope.matchingVideos.length > 0
      $scope.activeVideo = $scope.matchingVideos[0]
      $scope.activeUrl = $scope.activeVideo.video.url
      $http.get("#{$scope.activeVideo.venue._videosUrl}?api_key=webdevtest")
        .success (data, status) ->
          if Object.keys(data).length > 1
            $scope.hasMoreVideos = true
            for vid in data
              $scope.venueVideos.push vid
              $scope.matchingVideos.push vid
          else
            $scope.hasMoreVideos = false
        .error (data, status) ->
          $scope.hasMoreVideos = false
    $scope.getLocation()
]


