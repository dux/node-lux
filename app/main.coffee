BaseCell = load_module 'cells/base_cell'
UserCell = load_module 'cells/user_cell'

module.exports = ->
  console.log @path if @req.url != '/favicon.ico'

  base_cell = new BaseCell(@) # we pass instance of lux

  return base_cell.favicon() if @req.url == '/favicon.ico'
  return base_cell.root() if @req.url == '/'

  path = @req.url.split('/')
  path.shift()
  root = path.shift()

  return base_cell.api(path) if root == 'api'
  return new UserCell(@).respond(path) if root == 'users'

  return base_cell.not_found()
