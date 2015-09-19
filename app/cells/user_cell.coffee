module.exports = class UserCell
  constructor: (@page) -> @

  respond: (path) ->
    return @index() unless path[0]
    return @show(path[0])

  index: ->
    '<li>Dino</li><li>Igor</li>'

  show: (id) ->
    @page.render('users/show', { id:id, name:'Dino' })
