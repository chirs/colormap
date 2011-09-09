$(->
  HEIGHT = 650
  WIDTH = 1250

  WHITE = "#FFFFFF"
  RED = "#E01B4C"
  ORANGE = "#F59433"
  YELLOW = "#FFFC52"
  BLUE = "#2359FA"

  eventMap =
    terror: [
      [new Date(2001, 9, 11), "9/11 Attacks"],
      [new Date(2001, 10, 7), "War in Afghanistan begins"],
      [new Date(2002, 3, 12), "Terror alert levels instituted"],
      [new Date(2003, 3, 20), "War in Iraq begins"],
      [new Date(2003, 12, 13), "Saddam Hussein captured"],
      [new Date(2004, 1, 16), "Abu Ghraib investigation begins"],
      [new Date(2004, 11, 2), "George Bush re-elected"],
      [new Date(2005, 7, 7), "7/7 bombings in London"],
      [new Date(2006, 3, 12), "Mahmudiya killings"],
      [new Date(2008, 11, 4), "Barack Obama elected"],
      [new Date(2011, 4, 27), "Terror alert levels eliminated"],
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

    wars: [
      [new Date(2001, 10, 7), "Enduring Freedom: Afghanistan"],
      [new Date(2002, 1, 15), "Enduring Freedom: Philippines"],
      [new Date(2002, 10, 7), "Enduring Freedom: Horn of Africa"],
      [new Date(2007, 2, 6), "Enduring Freedom: Trans Sahara"],
      [new Date(2003, 3, 20), "Iraqi Freedom"],
      [new Date(2004, 3, 16), "War in North-West Pakistan"],
      [new Date(2010, 1, 14), "Yemeni al-Qaeda crackdown"],
      [new Date(2003, 9, 11), "Liberian Civil War"],
      [new Date(2004, 2, 5), "Haitian Civil War"],
      [new Date(2011, 3, 19), "Libyan Civil War"],
      ]



  # Terror levels.
  spanMap =
    terror: [
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

    history: [
      [new Date(1901, 9, 14), RED],
      [new Date(1909, 3, 4), RED],
      [new Date(1913, 3, 4), BLUE],
      [new Date(1921, 3, 4), RED],
      [new Date(1923, 8, 2), RED],
      [new Date(1929, 3, 4), RED],
      [new Date(1933, 3, 4), BLUE],
      [new Date(1945, 4, 12), BLUE],
      [new Date(1953, 1, 20), RED],
      [new Date(1961, 1, 20), BLUE],
      [new Date(1963, 11, 22), BLUE],
      [new Date(1969, 1, 20), RED],
      [new Date(1974, 8, 9), RED],
      [new Date(1977, 1, 20), BLUE],
      [new Date(1981, 1, 20), RED],
      [new Date(1989, 1, 20), RED],
      [new Date(1993, 1, 20), BLUE],
      [new Date(2001, 1, 20), RED],
      [new Date(2009, 1, 20), BLUE],
    ]


  heightCounter = () ->
    y = 50

    obj =
      nextHeight: () ->
        if y > HEIGHT
          y = 50
        n = y
        y += 40

    obj

  # Make height steadily decline.
  hc = heightCounter()
  sequentialHeight = hc.nextHeight
  randomHeight = () -> Math.floor(Math.random() * HEIGHT)

  getDiff = (spans) ->
    l = spans.length
    seconds = spans[l-1][0] - spans[0][0]
    seconds

  secondsFromStart = (date, spans) ->
    date - spans[0][0]

  # looks like we need to create an init function or something...

  pixelsFromStart = (date, spans) ->
    decimal = secondsFromStart(date, spans) / getDiff(spans)
    Math.round(decimal * WIDTH)

  getPoint = (date, spans) ->
    return [pixelsFromStart(date, spans), sequentialHeight()]


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
    # Spans is passed around everywhere because we have to know the
    # start and end dates of the map.
    # would be better to initialize an object with the span immutable

    for tuple in spans
      [date, hex] = tuple
      pixelStart = pixelsFromStart(date, spans)
      drawRectangle(pixelStart, hex)

    for tuple in events
      [date, text] = tuple
      point = getPoint(date, spans)
      drawBox(point, "#000000", text)


  drawCanvas(spanMap.terror, eventMap.wars)

  $("li").click( ->
    eventName = $(this).html()
    drawCanvas(spanMap.terror, eventMap[eventName])

  )



)