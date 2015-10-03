axios = require 'axios'

module.exports = class UserCell extends load_module('cells/app_cell')

  index: ->
    @page.render('gallery/index')

  show: (id) ->
    axios.get("http://imgur.com/gallery/#{id}.json").then (res) =>
      @page.render('gallery/show', res.data.data.image.album_images)

