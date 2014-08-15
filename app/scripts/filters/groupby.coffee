'use strict'
angular.module('feedmeseymoreApp')
  .filter 'groupBy', ->
    (data) ->
      count = 0
      items = [[]]
      for vid, index in data
        if count <= 3
          if index is 0
            items[count].push vid
          else if index % 4 isnt 0
            items[count].push vid
          else if index % 4 is 0
            count += 1
            items[count] = []
            items[count].push vid
      return items
