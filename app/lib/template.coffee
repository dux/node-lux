# http://howtonode.org/haml-for-javascript

fs = require('fs')

module.exports = class Template
  constructor: -> 1

  load: (name) ->
    fs.readFileSync("../views/#{name}.haml", 'utf8');

  render:(name, locals) ->
    data = @load(name)
    Haml.render(data, locals)
