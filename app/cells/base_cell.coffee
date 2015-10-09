# https://github.com/balderdashy/waterline
# ovo probat

Sequelize = require('sequelize');
sequelize = new Sequelize 'stash_buckets_new', 'dux', '!Netlife',
  host: 'localhost',
  dialect: 'postgres',
  pool:
    max: 5,
    min: 0,
    idle: 10000

LinkModel = sequelize.define 'links',
  name: { type: Sequelize.STRING  },
  url: { type: Sequelize.STRING }
,
  freezeTableName: true

s = $.speed ->
  LinkModel.findAll(attributes:['id', 'name', 'url']).then (links) ->
    s();
    # for el in links
    #   console.log el.name

module.exports = class BaseCell extends load_module('cells/app_cell')
  
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

  db: ->
    'asdas'

