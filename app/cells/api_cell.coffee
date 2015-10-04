module.exports = class ApiCell
  
  constructor: (@page) -> @

  respond: ->
    klass  = @page.path[0]
    action = @page.path[1]

    # load API module
    try
      api = load_module "api/#{klass}_api"
    catch e
      return error:'Api class not found' if e.code == 'MODULE_NOT_FOUND'
      return error:'Api error', description:String(e)

    data = {}
    data.ip = @page.req.connection.remoteAddress
    data.ip = '127.0.0.1' if data.ip == '::1'

    # pass parameters
    if api[action]
      params = $.spawn({}, (@page.req.body || {}))
      $.merge params, @page.qs if @page.qs?
      # data.params = params

      try
        data.data = api[action].call(@page, params)
      catch e
        data.error = String(e)

    else
      data = "API ERROR: No action #{action} in #{klass}_api"  

    data
