$(->
  HEIGHT = 650
  WIDTH = 1250

  WHITE = "#FFFFFF"
  RED = "#E01B4C"
  ORANGE = "#F59433"
  YELLOW = "#FFFC52"
  BLUE = "#2359FA"

  eventMap =
    war: [
      [new Date(2001, 9, 11), "9/11 Attacks"],
      [new Date(2001, 10, 7), "War in Afghanistan begins"],
      [new Date(2003, 3, 20), "War in Iraq begins"],
      [new Date(2003, 12, 13), "Saddam Hussein captured"],
      [new Date(2004, 11, 2), "George Bush re-elected"],
      [new Date(2005, 7, 7), "7/7 bombings in London"],
      [new Date(2008, 11, 4), "Barack Obama elected"],
      [new Date(2011, 5, 2), "Osama bin Laden killed"],
      ]

    film: [
      [new Date(2001, 12, 16), "Harry Potter and the Philosopher's Stone"],
      [new Date(2003, 5, 30), "Finding Nemo"],
      [new Date(2003, 12, 17), "Lord of the Rings: Return of the King"],
      [new Date(2005, 5, 15), "Star Wars Episode III: Revenge of the Sith"],
      [new Date(2006, 12, 22), "Night at the Museum"],
      [new Date(2008, 7, 14), "The Dark Knight"],
      ]


  # Terror levels.
  terrorSpans = [
    [new Date(2001, 9, 1), WHITE],
    [new Date(2001, 9, 11), WHITE],
    [new Date(2002, 3, 12), YELLOW],
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
    [new Date(2011, 4, 27), WHITE],
    ]

  randomHeight = () -> Math.floor(Math.random() * HEIGHT)


  getDiff = ->
    l = terrorSpans.length
    seconds = terrorSpans[l-1][0] - terrorSpans[0][0]
    seconds

  secondsFromStart = (date) ->
    date - terrorSpans[0][0]

  pixelsFromStart = (date) ->
    decimal = secondsFromStart(date) / getDiff()
    console.log(decimal * WIDTH)
    Math.round(decimal * WIDTH)

  getPoint = (date) ->
    return [pixelsFromStart(date), randomHeight()]


  canvas = $("canvas")[0]
  ctx = canvas.getContext('2d')
  ctx.font = "bold 12px sans-serif"

  drawBox = (center, hex, text) ->
    [x, y] = center
    ctx.fillStyle = hex
    DISTANCE = 5
    ctx.fillRect(x-DISTANCE, y-DISTANCE, DISTANCE * 2, DISTANCE * 2)
    ctx.fillText(text, x + DISTANCE * 2, y)

  drawRectangle = (start, hex) ->
    ctx.fillStyle = hex
    ctx.fillRect(start,0,WIDTH, HEIGHT)

  drawCanvas = (spans, events) ->
    for tuple in spans
      [date, hex] = tuple
      pixelStart = pixelsFromStart(date)
      console.log(pixelStart)
      drawRectangle(pixelStart, hex)

    for tuple in events
      [date, text] = tuple
      point = getPoint(date)
      drawBox(point, "#000000", text)


  drawCanvas(terrorSpans, eventMap.war)

  $("li").click( ->
    eventName = $(this).html()
    drawCanvas(terrorSpans, eventMap[eventName])

  )



)