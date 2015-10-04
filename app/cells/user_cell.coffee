Users  = load_module 'models/user'

module.exports = class UserCell extends load_module('cells/app_cell')

  index: ->
    @render users:Users.all()

  show: (id) ->
    user = Users.get(id)
    return @error "User with id #{id} is not found" unless user
    @render user:user
  
  login: ->
    @render()
