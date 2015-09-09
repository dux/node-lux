Url         = require('url')
querystring = require('querystring')

Template = load_module 'lib/template'

module.exports = class Lux
  constructor: (@req, @res) ->
    @url = Url.parse(@req.url)
    @path = @url.pathname
    @qs = querystring.parse @url.query
    @

  exec: (func)->
    if func
      @body = func.call(this)
    else
      @body = 'Error: function not provided'

  end: ->
    if @body
      # convert to javascript if object recieved
      if typeof @data == 'object'
          @res.writeHead(200, {'Content-Type': 'text/javascript'});
          @body = JSON.stringify(@body, null, 2)
      else
        @body = @body.replace(/$\s+/,'')

        if @body.substr(0,1) != '<'
          @res.writeHead(200, {'Content-Type': 'text/plain'});
        else
          @res.writeHead(200, {'Content-Type': 'text/html'});

    @res.end(@body)

  render: ->
    12345
