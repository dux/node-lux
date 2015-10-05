# What?

Port of Ruby web framework Lux to JavaScript

Written in CoffeeScript

* full working app
  * session
  * models
  * router
  * controller/cell
  * view render (haml)


## install

npm install

nodemon app/index.coffee



## rotuer looks like this

basic router that just routes to user controler or displays not found page

```
module.exports = ->
  root = @root_path.singularize
  return @cell('user').respond() if root == 'user'
  @cell('base').not_found()

```


## user_cell

This is complete user cell

```
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

  profile: ->
    @render_with_layout('user/profile')

  bye: ->
    delete @page.session.id
    @page.redirect('/')
    return 'Redirecting to root...'
```