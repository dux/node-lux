crypt = load_module 'lux/crypt'

module.exports =
  init: ->
    @cookies = {}

    for cookie in String(@req.headers.cookie).split(';')
      vals = cookie.split(/[=,]/)
      @cookies[vals[0]] = vals[1] if vals[1]

    if @cookies['lux_node']
      try
        @session = JSON.parse crypt.simple.decrypt @cookies['lux_node']
      catch
        @session = {}

  save: ->
    console.log @session

    s = crypt.simple.encrypt JSON.stringify(@session)
    @header('Set-Cookie',"lux_node=#{s};path=/;max-age=#{3600*24*31}")
