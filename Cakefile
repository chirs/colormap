fs = require 'fs'
{exec} = require 'child_process'
util = require 'util'

coffeedir = 'src/server'
jsdir = 'lib/server'

coffeeOptions = "--bare --output #{jsdir} "

coffeedir2 = 'src/client'
jsdir2 = 'lib/client'

coffeeOptions2 = "--bare --output #{jsdir2} "


compile = (file, dir, opts) ->
  parts = file.split('.', 1)
  if(/(.*)\.(coffee)/i.test(file))
    compileCoffee(parts[0], dir, opts)
    fileRef = file
    util.log " -> #{dir}/#{file}"
    fs.watchFile "#{dir}/#{file}", (curr, prev) ->
      if +curr.mtime isnt +prev.mtime
        util.log "Saw change in #{dir}/#{fileRef}"
        compileCoffee(parts[0], opts)

task 'watch', 'Watch for coffeescript and less changes', ->
  util.log "Watching for code changes to:"

  fs.readdir(coffeedir, (err, files)->
    for file in files
      compile(file, coffeedir, coffeeOptions)
  )

  fs.readdir(coffeedir2, (err, files)->
    for file in files
      compile(file, coffeedir2, coffeeOptions2)
  )

  #compile("package.json", coffeeOptions)

  util.log "Performed initial compile. Ready and waiting for changes"

# if you wanted to run these alone then you might as well do it from the command line
compileCoffee = (file, dir, opts) ->
  exec "coffee #{opts} #{dir}/#{file}.coffee", (error, stdout, stderr) ->
    util.log(stdout) if stdout
    util.log(stderr) if stderr
