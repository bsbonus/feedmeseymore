'use strict'

@feedmeseymoreApp.controller 'MainCtrl', ['$scope', '$location', '$http', ($scope, $location, $http, $log ) ->
  $scope.city = 'Austin'
  $scope.foodideas = [
    {img: 'testimg1.jpg',
    details:
      description: "bacon"
    },
    {img: 'testimg2.jpg',
    details:
      description: "veggies"
    },
    {img: 'testimg3.jpg',
    details:
      description: "meat"
    }
  ]


  $scope.getNewIdeas = ->
    $scope.foodideas = [
      {img: 'testimg4.jpg',
      details:
        description: "fish"
      },
      {img: 'testimg5.jpg',
      details:
        description: "pork"
      },
      {img: 'testimg6.jpg',
      details:
        description: "bbq"
      }
    ]
]

