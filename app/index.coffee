SERVER_PORT = 9000

global.is_on_production = process.env.NODE_ENV == 'production'
global.load_module      = (name) -> require "./#{name}"
global.APP_ROOT         = require('path').dirname(require.main.filename).replace('/app','');
global.$$               = require './lib/base_class_extensions'
global.Q                = require 'q'

require('better-require')() if is_on_production

http           = require('http')
Page           = load_module 'lib/page'
page_main_loop = load_module 'main'

main_loop = (req, res) ->
  console.log '---'
  lux = new Page(req, res)
  lux.exec page_main_loop
  lux.end()

http.createServer(main_loop).listen(SERVER_PORT)

console.log("Server running at http://127.0.0.1:#{SERVER_PORT}/")

