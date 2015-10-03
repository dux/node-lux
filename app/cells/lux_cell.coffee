module.exports = class LuxCell
  
  # tu definirati master layout
  constructor: (@page) -> 
    @template = 'layout'
    @

  render: ->
    args = Array.prototype.slice.call(arguments)
    method = args.shift()

    return "No method #{method} in Cell" unless @[method]

    body = @[method].call(@, args[0], args[1], args[2])

    body = @page.pointerize_template_if_promise(body)

    @page.render(@template, page_body:body)

