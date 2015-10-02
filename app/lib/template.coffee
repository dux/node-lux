# http://howtonode.org/haml-for-javascript
# https://github.com/creationix/haml-js
# faster? https://github.com/tj/haml.js

Haml = require 'hamljs'
fs   = require('fs')

scope_templates = {}
scope_widgets = {}

module.exports = (view, locals, scope) ->
  console.log "render: #{view}"

  scope_templates = {} unless is_on_production

  unless scope_templates[view]
    template = "#{APP_ROOT}/app/views/#{view}.haml"
    if fs.existsSync(template)
      @data = fs.readFileSync(template, 'utf8');
    else
      @data = '.lux-error Error: Template #{view} not found'

    scope_templates[view] = Haml.compile(@data)

  delete locals._keys

  locals._ = {}
  locals._.widget = (widget_name, arg1, arg2, agr3) ->
    try
      scope_widgets[widget_name] ||= load_module "widgets/#{widget_name}"
      body = scope_widgets[widget_name].call(scope, arg1, arg2, agr3)
    catch e
      body = "Widget [#{widget_name}] render error: #{e}"

    if typeof(body.then) == 'function'
      scope._pointer_data  ||= []
      scope._pointer_data.push body
      "[:pointer:#{scope._pointer_data.length - 1}:]"
    else
      return body

  scope_templates[view](locals, @);

# require 'jaml'

# Jaml.register 'simple', (data) ->
#   div(
#     h1("Some title: #{data.title}"),
#     p('Some exciting paragraph text'),
#     br(),
#     ul(
#       li('First item'),
#       li('Second item'),
#       li('Third item')
#     )
#   )

# console.log Jaml.render('simple', { title:'Krasne' })