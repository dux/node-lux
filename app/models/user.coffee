crypto = require('crypto')

class User
  name: ->
    "#{@data.name} (#{@data.email})"

  path: ->
    "/user/#{@data.id}"

  avatar_url: ->
    "https://s.gravatar.com/avatar/" + crypto.createHash('md5').update(@data.email.toLowerCase()).digest('hex');  

Users =
  all: -> user_list
  
  init: (opts)->
    usr = new User
    usr.data = opts
    usr

  get: (id) ->
    id = parseInt(id)

    for el in @all()
      return el if el.data.id == id
    
  login: (email, pass) ->
    for el in users
      return el if el.email == email && el.pass == pass

user_list = []
user_list.push Users.init { id:1, name:'Dux', email:'rejotl@gmail.com', pass:'rejotl' }
user_list.push Users.init { id:2, name:'John', email:'john.doe@gmail.com', pass:'john' }
user_list.push Users.init { id:3, name:'Mike', email:'mike@gmail.com', pass:'mike' }
user_list.push Users.init { id:4, name:'Paul', email:'paul@ycombinator.com', pass:'paul' }

module.exports = Users




