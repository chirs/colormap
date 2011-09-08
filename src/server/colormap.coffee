app = require './app'

app.listen 28888
console.log("Express server listening on port %d", app.address().port)
