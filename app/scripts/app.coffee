'use strict'

@feedmeseymoreApp = angular.module('feedmeseymoreApp', ['ngCookies', 'ngResource', 'ngSanitize', 'ui.router', 'com.2fdevs.videogular', 'google-maps'])

@feedmeseymoreApp.config( ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $stateProvider
    .state('landing', {url: '/', templateUrl: "views/main.html", controller: 'MainCtrl' })
    .state('chomps', {url: '/chomps/:name', templateUrl: '/views/chomps.html', controller: 'FoodCtrl'})
])

