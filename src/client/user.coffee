$(->
  HEIGHT = 500
  WIDTH = 1024 # pixels

  events = []

  dateTuples = [
    [new Date(1983, 1, 5), "#cccccc"],
    [new Date(1983, 6, 5), "#f0f0f0"],
    [new Date(1986, 3, 5), "#aaaaaa"],
    [new Date(1987, 1, 5), "#eeeeee"]
    ]

  getDiff = ->
    l = dateTuples.length
    seconds = dateTuples[l-1][0] - dateTuples[0][0]
    seconds

  secondsFromStart = (date) ->
    date - dateTuples[0][0]

  pixelsFromStart = (date) ->
    decimal = secondsFromStart(date) / getDiff()
    console.log(decimal * WIDTH)
    Math.round(decimal * WIDTH)

  canvas = $("canvas")[0]
  ctx = canvas.getContext('2d')

  drawRectangle = (start, hex) ->
    ctx.fillStyle = hex
    ctx.fillRect(start,0,WIDTH, HEIGHT)

  for tuple in dateTuples
    [date, hex] = tuple
    pixelStart = pixelsFromStart(date)
    console.log(pixelStart)
    drawRectangle(pixelStart, hex)

  $( "#datepicker" ).datepicker()



)