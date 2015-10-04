axios = require 'axios'

module.exports = class GalleryCell extends load_module('cells/app_cell')

  index: ->
    @render()

  show: (id) ->
    axios.get("http://imgur.com/gallery/#{id}.json").then (res) =>
      @render res.data.data.image.album_images

