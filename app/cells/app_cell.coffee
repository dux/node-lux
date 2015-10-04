module.exports = class AppCell
  
  # tu definirati master layout
  constructor: (@page) -> 
    @template = 'layout'
    @

  respond: () ->
    return @layout('index') unless @page.path[0]
    return @layout('show', @page.path[0])# if String(parseInt(@page.path[0])) == @page.path[0]
    #return @layout(@page.path[1] || @root_path)

  layout: ->
    args = Array.prototype.slice.call(arguments)
    method = @action = args.shift()

    return "No method #{method} in Cell" unless @[method]

    body = @[method].call(@, args[0], args[1], args[2])

    body = @page.pointerize_template_if_promise(body)

    @page.render(@template, BODY:body)

  # shortuct for @page.render, template, opts
  render: (locals) ->
    cell_name = @constructor.name.replace('Cell','').underscore

    return @error("@action is not defined, you have to call this like <b>@cell('#{cell_name}').layout('ACTION')</b>") unless @action
    
    @page.render "#{cell_name}/#{@action}", locals

  error: (desc) ->
    """<div class="alert alert-danger">#{desc}</div>"""

