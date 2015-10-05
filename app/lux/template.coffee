# http://howtonode.org/haml-for-javascript
# https://github.com/creationix/haml-js
# faster? https://github.com/tj/haml.js

# require 'jaml'
#
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

Haml = require 'haml-coffee' # https://github.com/netzpirat/haml-coffee
fs   = require('fs')

helpers = load_module 'lib/helpers'

page_templates = {}
scope_widgets = {}

# (layout, view, locals, scope)
# or 
# (view, locals, scope)
burnTemplate = ->
  args = Array.prototype.slice.call(arguments)
  if typeof(args[1]) == 'string'
    [layout, view, locals, scope] = args
  else
    [view, locals, scope] = args

  unless typeof(view) == 'string'
    console.log(error = 'FATAL TEMPLATE RENDER ERROR: expected view as a string, got object')
    console.log view
    return error

  page_templates = {} unless is_on_production

  unless page_templates[view]
    template = "#{APP_ROOT}/app/views/#{view}.haml"
    if fs.existsSync(template)
      @data = fs.readFileSync(template, 'utf8');
    else
      @data = '.lux-error Error: Template #{view} not found'

    page_templates[view] = Haml.compile(@data, cleanValue: false, escapeHtml: false, uglify:true )

  template_locals      = {}
  template_locals.H    = helpers
  template_locals.PAGE = scope

  locals ||= {}

  for k,v of locals
    template_locals[k] = v

  for k,v of scope.locals
    template_locals[k] = v

  template_locals.H.widget = (widget_name, arg1, arg2, agr3) ->
    try
      scope_widgets[widget_name] ||= load_module "widgets/#{widget_name}"
      body = scope_widgets[widget_name].call(scope, arg1, arg2, agr3)
    catch e
      body = "Widget [#{widget_name}] render error: #{e}"

    scope.pointerize_template_if_promise(body)

  try
    result = page_templates[view](template_locals)
  catch e
    result = "<div class='alert alert-danger'>Template <b>#{view}</b> render error<br/><br/>#{e}</div>"

  return result unless layout

  locals.BODY = result

  burnTemplate(layout, locals, scope)

module.exports = burnTemplate