axios = require 'axios'

module.exports = (name, size=200) ->
  axios.get("http://imgur.com/gallery/#{name}.json").then (res) =>
    ret = ["""<h4><a href="http://imgur.com/gallery/#{name}">gallery:#{name}</a></h4>"""]
    for el in res.data.data.image.album_images.images
      ret.push """<a href="http://i.imgur.com/#{el.hash}.png"><img src="http://i.imgur.com/#{el.hash}m.png" style="width:#{size}px; border:2px solid #aaa; margin:10px;" /></a>"""
    ret.join('')
