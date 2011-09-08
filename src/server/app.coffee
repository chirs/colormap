express = require 'express'
path = require 'path'
models = require './model'

baseDir = path.normalize "#{__dirname}/.."

app = module.exports = express.createServer()

app.configure( ->

  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

  app.use app.router

  app.set('views', "#{baseDir}/views")
  app.set('view engine', 'jade')
  app.use express.static("#{baseDir}/public")
  )


index = (req, res) ->
    res.render('index', { haikus: [] })

app.get('/', index)
