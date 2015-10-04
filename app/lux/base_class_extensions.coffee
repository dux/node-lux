# https://github.com/pksunkara/inflect
# inflect string ruby style, modify string tempalte
require('i')(true) 

# we use standard A+ node promises
Promise = require 'promise'

# it is safe to extend to Arrays and Strings, so we will do that
# http://howtonode.org/prototypical-inheritance
# ['user', 'gallery'].contains('user') -> true
Object.defineProperty Array.prototype, 'contains', value: (data) ->
  @indexOf(data) > -1

# 'user'.contains('us') -> true
Object.defineProperty String.prototype, 'contains', value: (data) ->
  @indexOf(data) > -1

# [1,2,3].last() -> 3
Object.defineProperty Array.prototype, 'last', value: (data) ->
  if @length then @[this.length - 1] else undefined

# removes blanks from array
Object.defineProperty Array.prototype, 'compact', value: (data) ->
  item for item in @ when item

# remove duplicates from array
Object.defineProperty Array.prototype, 'flatten', value: (data) ->
  flattened = []
  for element in this
    if '[object Array]' is Object::toString.call element
      flattened = flattened.concat flatten element
    else
      flattened.push element
  flattened

module.exports = $ = 
  # delete propery and return it
  del: (obj, key) ->
    val =  obj[key]
    delete obj[key]
    val

  # merge options to object
  merge: (object, properties) ->
    for key, val of properties
      object[key] = val
    object

  # create new object frcceing props
  spawn: (parent, props) ->
    defs = {}

    for key in props
      if props.hasOwnProperty(key)
        defs[key] = {value: props[key], enumerable: true}

    Object.create(parent, defs)

  # new Promise with closures is syntax pain in coffee script so this helps
  promise:
    create: (data) -> new Promise
    all: (list) -> new Promise.all(list)
    start: (resolve, reject) -> new Promise(resolve, reject)
    resolve: (data) -> Promise.resolve(data)

  # define: (object, name, type_or_func, opts={}) ->
  #   opts.configurable = true
  #   opts.enumarable = true

  #   @__values ||= {}

  #   # if typeof(type_or_func) == 'function'
  #   #    set_type_or_func = (val) => 
  #   #     @__values[name] = type_or_func(val)
  #   # else
  #   #   opts.enumarable = true
  #   #   set_type_or_func = (val) => 
  #   #     @__values[name] = val

  #   @_val = 1

  #   set_value = (val) => @_val = val
  #   get_value = => @_val

  #   Object.defineProperty object, name, 
  #     enumarable: true
  #     get: get_value
  #     set: set_value
        
