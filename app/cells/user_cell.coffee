axios = require 'axios'

module.exports = class UserCell extends load_module('cells/lux_cell')

  respond: (path) ->
    return @render('index') unless path[0]
    return @render('show', path[0])

  index: ->
    '<li>Dino</li><li>Igor</li>'

  show: (id) ->
    @page.render('users/show', { id:id, name:'Dino' })

  gallery: ->
    axios.get('http://imgur.com/gallery/J44eo.json').then (res) =>
      console.log 'adasdasd'
      @page.render('users/gallery', res.data.data.image.album_images)

  promise: ->
    $$.promise.start (res) ->
      res 'abc'

  inline_gallery: ->
    @page.render('users/inline_gallery')
