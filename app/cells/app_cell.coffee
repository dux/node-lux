module.exports = class AppCell
  
  # tu definirati master layout
  constructor: (@page) -> 
    @template = 'layout'
    @

  respond: () ->
    return @layout('index') unless @page.path[0]
    return @layout('show', @page.path[0])

  layout: ->
    args = Array.prototype.slice.call(arguments)
    method = args.shift()

    return "No method #{method} in Cell" unless @[method]

    body = @[method].call(@, args[0], args[1], args[2])

    body = @page.pointerize_template_if_promise(body)

    @page.render(@template, BODY:body)

  error: (desc) ->
    """<div class="alert alert-danger">#{desc}</div>"""

