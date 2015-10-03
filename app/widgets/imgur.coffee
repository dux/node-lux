axios = require 'axios'

module.exports = (name, size=200) ->
  time = new Date()
  axios.get("http://imgur.com/gallery/#{name}.json").then (res) =>
    new_time = new Date()
    ret = ["""<h4><a href="http://imgur.com/gallery/#{name}">gallery:#{name}</a>: #{new_time - time} ms</h4>"""]
    for el in res.data.data.image.album_images.images
      ret.push """<a href="http://i.imgur.com/#{el.hash}.png"><img src="http://i.imgur.com/#{el.hash}m.png" style="width:#{size}px; border:2px solid #aaa; margin:10px;" /></a>"""
    ret.join('')
