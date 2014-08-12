'use strict'

@feedmeseymoreApp.controller 'MainCtrl', ['$scope', '$location', '$http', '$state', ($scope, $location, $http, $state ) ->
  $scope.city = 'Austin'
  $scope.foodideas = [
    {img: 'images/testimg1.jpg',
    details:
      description: "bacon"
      tag_id: 12
    },
    {img: 'images/testimg2.jpg',
    details:
      description: "veggies"
      tag_id: 20
    },
    {img: 'images/testimg3.jpg',
    details:
      description: "meat"
      tag_id: 15
    }
  ]


  $scope.getNewIdeas = ->
    ideas = ['fish', 'meat', 'coffee']
    lat = 34.1173
    long = -118.2600
    url = "https://api.tmade.co/v1/nearby/videos?lat=#{lat}&long=#{long}&api_key=webdevtest"
    api_key = 'webdevtest'

    tag_url = "https://api.tmade.co/v1/tags/#{ideas[0]}?&api_key=webdevtest"
    $http.get(tag_url).success (data) ->
      thumbUrl = data.titleImage.url.replace(/dg14fekn8y2fu/, 'd2inek5pdajgud')
      $scope.foodideas[0]['img'] = "#{thumbUrl}&api_key=#{api_key}"
      $scope.foodideas[0]['details']['description'] = data.title
      $scope.foodideas[0]['details']['tag_id'] = data._id

    tag_url = "https://api.tmade.co/v1/tags/#{ideas[1]}?&api_key=webdevtest"
    $http.get(tag_url).success (data) ->
      thumbUrl = data.titleImage.url.replace(/dg14fekn8y2fu/, 'd2inek5pdajgud')
      $scope.foodideas[1]['img'] = "#{thumbUrl}&api_key=#{api_key}"
      $scope.foodideas[1]['details']['description'] = data.title
      $scope.foodideas[1]['details']['tag_id'] = data._id

    tag_url = "https://api.tmade.co/v1/tags/#{ideas[2]}?&api_key=webdevtest"
    $http.get(tag_url).success (data) ->
      console.log(data)
      thumbUrl = data.titleImage.url.replace(/dg14fekn8y2fu/, 'd2inek5pdajgud')
      $scope.foodideas[2]['img'] = "#{thumbUrl}&api_key=#{api_key}"
      $scope.foodideas[2]['details']['description'] = data.title
      $scope.foodideas[2]['details']['tag_id'] = data._id


  $scope.getFoodIdea = (tagId) ->
    #$state.go('chomps')
    $location.path "/chomps"
]

