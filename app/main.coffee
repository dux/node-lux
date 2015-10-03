# routes resolve and master controller

module.exports = ->

  root = @root_path.singularize

  if root == ''
    @cell('base').layout('root')

  else if ['user', 'gallery'].contains(root)
    @cell(root).respond()

  else
    @cell('base').not_found()

