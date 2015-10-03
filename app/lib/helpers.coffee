module.exports = 
  link_to: (name, path) ->
    """<a href="#{path}">#{name}</a> """

  main_menu: (root) ->
    menu = []
    menu.push ['/','Home']
    menu.push ['/users','Users']
    menu.push ['/gallery','Gallery']
    menu.push ['/api','Api']
    
    menu = menu.map (el) ->
      klass = ''
      klass = ' class="active"' if el[0].pluralize == "/#{root.pluralize}"
      """<li#{klass}><a href="#{el[0]}">#{el[1]}</a></li>"""
    
    menu.join('')

  user_menu: ->
    menu = []
    menu.push ['/login','Login']
    
    menu = menu.map (el) ->
      klass = ''
      klass = ' class="active"' if false
      """<li#{klass}><a href="#{el[0]}">#{el[1]}</a></li>"""
    
    menu.join('')
