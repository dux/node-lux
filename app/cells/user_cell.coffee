module.exports = class UserCell
  constructor: (@lux) -> @

  respond: (path) ->
    return @index() unless path[0]
    return @show(path[0])

  index: ->
    '<li>Dino</li><li>Igor</li>'

  show: (id) ->
    "<h4>Dino: #{id}</li>"
