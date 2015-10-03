Url         = require('url')
querystring = require('querystring')

template_render = load_module 'lux/template'
static_file     = load_module 'lux/static_file'
cell_objects    = {}

module.exports = class Page
  constructor: (@req, @res) ->
    @url = Url.parse(@req.url)
    @path = @url.pathname.split('/'); @path.shift()
    @root_path = @path.shift()
    @qs = querystring.parse @url.query
    @content_type = ''
    @headers = {}
    @status
    @

  set_content_type: (type) -> 
    type = 'text/plain' if type == 'text'
    type = 'text/javascript' if type == 'js'
    @content_type = type

  exec: (func)->
    if func
      @body = func.call(@)
    else
      @body = 'Error: function not provided'

  redirect: (url, @status=300) ->
    @header('Location', url)

  header: (key, val) ->
    @headers[key] = val if key
    @headers

  error: (desc, @status=500) ->
    @_error = desc

  end: ->
    if @_error
      @set_content_type('text')
      @status ||= 500
      @body = "Error: #{@_error}"

    if typeof(@body.then) == 'function'
      @body.then (data) =>
        # @body.done() if typeof(@body.done) == 'function'
        @body = data
        @end_finalize_promises()
    else
      @end_finalize_promises()
  
  end_finalize_promises: ->
    if @_pointer_data
      $.promise.all(@_pointer_data).then (data) =>
        for i in [0..data.length-1]
          @body = @body.replace("[:pointer:#{i}:]", data[i])
        @end_finalize_finish()
    else
      @end_finalize_finish()

  end_finalize_finish: ->
    if @body && ! @is_binary
      # convert to javascript if object recieved
      if typeof(@body) == 'object'
        @content_type ||= 'text/javascript'
        @body = JSON.stringify(@body, null, 2)
      else
        @body = String(@body).replace(/^\s+/,'')

        if @body.substr(0,1) != '<'
          @content_type ||= 'text/plain'
        else
          @content_type ||= 'text/html'

    @headers['Content-Type'] = @content_type || '? err'

    @status ||= 200

    @header('Content-length', @body.length)

    @res.writeHead(@status, @headers);

    binary = if @is_binary then 'binary' else 'utf-8'

    @res.end(@body, binary)


  render: (view, opts={}) ->
    template_render(view, opts, @)


  pointerize_template_if_promise: (data) ->
    return data unless typeof(data.then) == 'function'

    @_pointer_data  ||= []
    @_pointer_data.push(data)
    
    "[:pointer:#{@_pointer_data.length - 1}:]"


  cell:(name) ->
    cell_objects[name] ||= load_module "cells/#{name}_cell"
    new cell_objects[name](@)

