'use strict'

angular.module('feedmeseymoreApp')
  .factory 'NearbyVids', ($http, $q) ->
    getNearbyVideos: (lat, long, callback) ->
      return $http.get("https://api.tmade.co/v1/nearby/videos?lat=#{lat}&long=#{long}&api_key=webdevtest")
