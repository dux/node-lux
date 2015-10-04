# routes resolve and master controller

module.exports = ->

  root = @root_path.singularize

  return @cell('base').layout('root')  if root == ''
  return @cell('api').respond()        if root == 'api'
  return @cell('gallery').respond()    if root == 'gallery'
  return @cell('user').layout('login') if root == 'login'
  return @cell('user').respond()       if root == 'user'

  @cell('base').not_found()

