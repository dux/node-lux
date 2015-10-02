module.exports = class BaseCell
  
  # tu definirati master layout


  constructor: (@lux) -> @

  root: ->
    """<body><h3>Hallo</h3><p>This is html index. Try</p><ul>
      <li><a href="/bla">/bla (not found)</a></li>
      <li><a href="/api/users">/api/users (generic api)</a></li>
      <li><a href="/users">/users (user list)</a></li>
      <li><a href="/users/4">/users/4 (single user)</a></li>
      <li><a href="/gallery">gallery</a></li>
      <li><a href="/inline_gallery">inline_gallery</a></li>
      <li><a href="/promise">promise</a></li>
    </ul></body> """

  api: (path)->
    class:   path[0]
    method:  path[1]
    message: 'ok'

  not_found: ->
    'Page not found'
