'use strict'

@feedmeseymoreApp.controller 'MainCtrl', ['$scope', '$location', '$http', '$state', ($scope, $location, $http, $state ) ->
  $scope.city =
    name: 'Austin'
    coords:
      latitude: 30.2500,
      longitude: -97.7500

  $scope.idealist = ['bacon', 'bbq', 'meat', 'sausage', 'cheese', 'dessert', 'tacos', 'coffee', 'wine', 'beer', 'whiskey']
  $scope.usedIdeas = {}
  $scope.foodideas = []
  $scope.status =
    isopen: false
  $scope.changeCity = (city) ->
    $scope.city.name = city
    $scope.city.coords.latitude = $scope.geoData[city.toLowerCase().replace(" ", "_")].latitude
    $scope.city.coords.longitude = $scope.geoData[city.toLowerCase().replace(" ", "_")].longitude

  $scope.toggleDropdown = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.status.isopen = !$scope.status.isopen

  $scope.geoData =
    austin:
      latitude: 30.2500,
      longitude: -97.7500
    los_angeles:
      latitude: 34.0500,
      longitude: -118.2500
    chicago:
      latitude: 41.8819
      longitude: -87.6278
    san_diego:
      latitude: 32.7150
      longitude: -117.1625

  $scope.cityCoords = [
    {name: 'Austin',
    coords:
      latitude: 30.2500,
      longitude: -97.7500
    },
    {name: 'Los Angeles'
    coords:
      latitude: 30.2500,
      longitude: -97.7500
    },
    {name: 'Chicago'
    coords:
      latitude: 41.8819
      longitude: -87.6278
    },
    {name: 'San Diego'
    coords:
      latitude: 32.7150
      longitude: -117.1625
    }
  ]

  $scope.getIdea = (name, i) ->
    url = "https://api.tmade.co/v1/tags/#{name}?&api_key=webdevtest&callback=JSON_CALLBACK"
    $http.jsonp(url).success (data) ->
      thumbUrl = data.titleImage.url.replace(/dg14fekn8y2fu/, 'd2inek5pdajgud')
      title = data.slug
      tag_id = data._id
      info = {
        img: "/images/tag_placeholders/reformatted/placeholder#{i}.jpg",
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

  $scope.gotoRandom = ->
    randomNum = Math.floor(Math.random() * ($scope.idealist.length))
    if $scope.usedIdeas[$scope.idealist[randomNum]] == undefined
      $location.path "/chomps/#{$scope.idealist[randomNum]}"
    else
      $scope.gotoRandom()

  $scope.getRandomIdea = ->
    randomNum = Math.floor(Math.random() * ($scope.idealist.length))
    if $scope.usedIdeas[$scope.idealist[randomNum]] == undefined
      $scope.getIdea($scope.idealist[randomNum], randomNum)
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

