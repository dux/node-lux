SERVER_PORT = 8001

require('better-require')()
require('hamljs')

global.load_module = (name) ->
  require "./app/#{name}"

http     = require('http')
Lux      = load_module 'lib/lux'
lux_main = load_module 'main'

main_loop = (@req, @res) ->
  lux = new Lux(req, res)
  lux.exec lux_main
  lux.end()

http.createServer(main_loop).listen(SERVER_PORT)

console.log("Server running at http://127.0.0.1:#{SERVER_PORT}/")
