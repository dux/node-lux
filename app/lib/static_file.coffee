fs   = require('fs')

module.exports = 
  ext: (file) -> $$.last(file.split('.')).toLowerCase()

  is_static_file: (file) ->
    return $$.has(['ico','png','jpg','jpeg','gif','txt'], @ext(file)) && fs.existsSync("#{APP_ROOT}/public#{file}")

  deliver: (page, file) ->
    ext = @ext(file)
    public_file = "#{APP_ROOT}/public#{file}"

    unless fs.existsSync(public_file)
      page.status = 404
      return """File "#{file}" does not exist.\n"""

    page.header('Cache-control', "public, max-age=10000000, no-transform")
    page.header('Expires', new Date(Date.now() + 10000000000).toUTCString())

    if ext == 'txt'
      page.set_content_type('text/plain') 
      return fs.readFileSync(public_file, 'utf8')+"\n"
    else
      # page.header("Content-Disposition", "attachment; filename=#{$$.last(file.split('/'))}")
      if ext == 'ico'
        page.set_content_type("image/x-icon")
      else
        page.set_content_type("image/#{ext}")

      page.is_binary = true
      return fs.readFileSync(public_file)

