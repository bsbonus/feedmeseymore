'use strict'

@feedmeseymoreApp.controller 'MainCtrl', ['$scope', '$location', '$http', '$state', ($scope, $location, $http, $state ) ->
  $scope.city = 'Austin'
  $scope.idealist = ['bacon', 'bbq', 'meat', 'sausage', 'cheese', 'dessert', 'tacos', 'coffee', 'wine', 'beer', 'whiskey']
  $scope.usedIdeas = {}
  $scope.foodideas = []

  $scope.getIdea = (name, i) ->
    instagramUrl = "https://api.instagram.com/v1/tags/#{name}/media/recent?access_token=273622212.1fb234f.ee69eed3d6e4455b9523d83f4ef27b12&callback=JSON_CALLBACK"
    url = "https://api.tmade.co/v1/tags/#{name}?&api_key=webdevtest&callback=JSON_CALLBACK"
    $http.jsonp(url).success (data) ->
      thumbUrl = data.titleImage.url.replace(/dg14fekn8y2fu/, 'd2inek5pdajgud')
      title = data.slug
      tag_id = data._id
      info = {
        img: "/images/testimg#{i}.jpg",
        details:
          description: title
          tag_id: tag_id
      }
      $scope.foodideas.push info

  $scope.setCoords = (position)->
    $scope.coords = position.coords

  $scope.getLocation = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition($scope.setCoords)



  $scope.getRandomIdea = ->
    randomNum = Math.floor(Math.random() * ($scope.idealist.length))
    if $scope.usedIdeas[$scope.idealist[randomNum]] == undefined
      $scope.getIdea($scope.idealist[randomNum], 1)
      $scope.usedIdeas[$scope.idealist[randomNum]] = true
      $scope.foodideas.shift()
    else
      if Object.keys($scope.usedIdeas).length is $scope.idealist.length
        $scope.usedIdeas = {}
      $scope.getRandomIdea()

  $scope.getNewIdeas = ->
    _(3).times ->
      $scope.getRandomIdea()

  $scope.getFoodIdea = (tagId) ->
    $location.path "/chomps"

  $scope.getNewIdeas()
  $scope.getLocation()
]

