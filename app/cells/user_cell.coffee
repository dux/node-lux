axios = require 'axios'

module.exports = class UserCell
  constructor: (@page) -> @

  respond: (path) ->
    return @index() unless path[0]
    return @show(path[0])

  index: ->
    '<li>Dino</li><li>Igor</li>'

  show: (id) ->
    @page.render('users/show', { id:id, name:'Dino' })

  gallery: ->
    axios.get('http://imgur.com/gallery/J44eo.json').then (res) =>
      console.log 'adasdasd'
      @page.render('users/gallery', res.data.data.image.album_images)

  promise: ->
    Q.fcall ->
      return 'abc'

  inline_gallery: ->
    @page.render('users/inline_gallery')
