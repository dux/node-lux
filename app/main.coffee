BaseCell = load_module 'cells/base_cell'
UserCell = load_module 'cells/user_cell'

static_file = load_module 'lib/static_file'

module.exports = ->
  console.log @path if @req.url != '/favicon.ico'

  # deliver static files
  return static_file.deliver(@, @path) if static_file.is_static_file(@path)

  base_cell = new BaseCell(@) # we pass instance of lux

  return base_cell.root() if @req.url == '/'

  path = @req.url.split('/')
  path.shift()
  root = path.shift()

  return base_cell.api(path) if root == 'api'
  return new UserCell(@).respond(path) if root == 'users'

  return base_cell.not_found()
