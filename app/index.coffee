SERVER_PORT = 9000

load_module_cache = {}

global.is_on_production = process.env.NODE_ENV == 'production'
global.load_module      = (name) -> load_module_cache[name] ||= require("./#{name}")
global.APP_ROOT         = require('path').dirname(require.main.filename).replace('/app','');
global.$                = require './lux/base_class_extensions'

require('better-require')() if is_on_production

http           = require('http')
Page           = load_module 'lux/page'
page_main_loop = load_module 'main'

main_loop = (req, res) ->
  console.log '---'
  
  page = new Page(req, res)
  page.deliver_if_asset()
  page.exec(page_main_loop)
  page.end()

http.createServer(main_loop).listen(SERVER_PORT)

console.log("Server running at http://127.0.0.1:#{SERVER_PORT}/")

