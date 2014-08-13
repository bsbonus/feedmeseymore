'use strict'

@feedmeseymoreApp.controller 'FoodCtrl', ['$scope', '$location', '$http', '$stateParams', '$sce', ($scope, $location, $http, $stateParams, $sce ) ->
  $scope.city = 'Portland, OR'
  $scope.tagHasVideos = false
  $scope.matchingVideos = []
  $scope.url = $sce.trustAsResourceUrl("https://d2aiijjnretqc1.cloudfront.net/cv/ez/cvezjiaxqwkpmfhr9ptisq/v1/360-600.mp4?")
  $scope.videoPoster = "/images/testimg2.jpg"
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

  $scope.setActiveVideo = (id) ->
    for vid in $scope.matchingVideos
      if vid._id is id
        $scope.activeVideo = vid
        $scope.activeUrl = vid.video.url

  $scope.trustVideo = (url) ->
    return $sce.trustAsResourceUrl url

  $http.get("https://api.tmade.co/v1/tags/#{$stateParams.name}/videos?api_key=webdevtest").success (data) ->
    for vid in data
      if vid.venue.geoName is $scope.city
        vid['adjustedThumbUrl'] = vid.thumbnail.url.replace(/dg14fekn8y2fu/, 'd2inek5pdajgud')
        $scope.matchingVideos.push vid
        $scope.tagHasVideos = true

    if $scope.matchingVideos.length > 0
      $scope.activeVideo = $scope.matchingVideos[0]
      $scope.activeUrl = $scope.activeVideo.video.url

    $http.get("#{$scope.activeVideo.venue._videosUrl}?api_key=webdevtest").success (data) ->
      if Object.keys(data).length > 1
        $scope.hasMoreVideos = true
]


