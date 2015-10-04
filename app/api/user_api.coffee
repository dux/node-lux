Users  = load_module 'models/user'

module.exports = 
  $load: (id) ->
    1

  login: (params) ->
    throw 'Email is not provided' unless params.email

    for usr in Users.all()
      if usr.data.email == params.email
        @session.id = usr.data.id
        return 'User login OK'

    throw 'Wrong email or password'
