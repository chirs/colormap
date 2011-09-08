$(->
  HEIGHT = 500
  WIDTH = 1024 # pixels

  RED = "#E01B4C"
  ORANGE = "#F59433"
  YELLOW = "#FFFC52"
  BLUE = "#2359FA"

  events = []

  dateTuples = [

    [new Date(2002, 3, 12), YELLOW], # Start
    [new Date(2002, 9, 10), ORANGE],
    [new Date(2002, 9, 25), YELLOW],
    [new Date(2003, 2, 7), ORANGE],
    [new Date(2003, 2, 28), YELLOW],
    [new Date(2003, 3, 17), ORANGE],
    [new Date(2003, 4, 17), YELLOW],
    [new Date(2003, 5, 20), ORANGE],
    [new Date(2003, 5, 31), YELLOW],
    [new Date(2004, 8, 1), ORANGE],
    [new Date(2004, 11, 10), YELLOW],
    [new Date(2005, 7, 7), ORANGE],
    [new Date(2005, 8, 12), YELLOW],
    [new Date(2006, 8, 10), RED],
    [new Date(2006, 8, 15), ORANGE],
    [new Date(2011, 4, 27), BLUE],
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