extra = {}

extra.has = (el, key) -> el.indexOf(key) > -1

extra.or = (c1, c2) -> c1 || c2

extra.compact = (array) ->
  item for item in array when item

extra.del = (obj, key) ->
  val =  obj[key]
  delete obj[key]
  val

extra.extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  object

extra.merge = (options, overrides) ->
  extend (extend {}, options), overrides

extra.flatten = (array) ->
  flattened = []
  for element in array
    if '[object Array]' is Object::toString.call element
      flattened = flattened.concat flatten element
    else
      flattened.push element
  flattened

extra.last = (list) -> if list.length then list[list.length - 1] else undefined

module.exports = extra;