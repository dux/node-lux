# http://howtonode.org/haml-for-javascript
# https://github.com/creationix/haml-js
# faster? https://github.com/tj/haml.js

Haml = require 'hamljs'
fs   = require('fs')

scope_templates = {}

module.exports = (view, locals) ->
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
  scope_templates[view](locals, this);


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