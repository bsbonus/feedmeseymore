'use strict'

@feedmeseymoreApp.controller 'FoodCtrl', ['$scope', '$location', '$http', '$stateParams', '$sce', ($scope, $location, $http, $stateParams, $sce ) ->
  $scope.city = 'Los Angeles, CA'
  $scope.tagHasVideos = false
  $scope.tagName = $stateParams.name
  $scope.matchingVideos = []
  $scope.url = $sce.trustAsResourceUrl("https://d2aiijjnretqc1.cloudfront.net/cv/ez/cvezjiaxqwkpmfhr9ptisq/v1/360-600.mp4?")
  $scope.videoPoster = "/images/testimg2.jpg"
  $scope.hasMoreVideos = false
  $scope.nearbyVideos = [[]]
  $scope.venueVideos = []
  $scope.coords =
    lat: 34.111063
    long: -118.27938379999998
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
      console.log $scope.activeVideo
      $scope.activeUrl = $scope.activeVideo.video.url
      $http.get("#{$scope.activeVideo.venue._videosUrl}?api_key=webdevtest")
        .success (data, status) ->
          if Object.keys(data).length > 1
            $scope.hasMoreVideos = true
            for vid in data
              $scope.venueVideos.push vid
            console.log $scope.venueVideos
          else
            $scope.hasMoreVideos = false
        .error (data, status) ->
          $scope.hasMoreVideos = false

    $scope.getLocation()


  $http.get("https://api.tmade.co/v1/nearby/videos?lat=#{$scope.coords.lat}&long=#{$scope.coords.long}&api_key=webdevtest")
    .success (data, status) ->
      count = 0
      for vid, index in data
        if count <= 3
          if index % 5 is 0 and index != 0
            count += 1
            $scope.nearbyVideos[count] = []
            $scope.nearbyVideos[count][index % 5 - 1] = vid
          else if index % 5 isnt 0
            $scope.nearbyVideos[count][index % 5 - 1] = vid
]


