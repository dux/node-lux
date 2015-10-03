BaseCell = load_module 'cells/base_cell'
UserCell = load_module 'cells/user_cell'

static_file = load_module 'lib/static_file'

module.exports = ->
  # deliver static files
  return static_file.deliver(@, @url.pathname) if static_file.is_static_file(@url.pathname)

  base_cell = new BaseCell(@) # we pass instance of lux
  return base_cell.render('root') unless @root_path

  return base_cell.api(@path) if @root_path == 'api'
  return new UserCell(@).respond(@path) if @root_path == 'users'
  return new UserCell(@).render('gallery') if @root_path == 'gallery'
  return new UserCell(@).render('promise') if @root_path == 'promise'
  return new UserCell(@).render('inline_gallery') if @root_path == 'inline_gallery'

  return base_cell.not_found()
