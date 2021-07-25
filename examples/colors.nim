import ../src/drawim

proc setup() =
  setColorMode(ColorMode.HSV)

proc draw() =
  beginPixels()
  for x in 0..<width:
    for y in 0..<height:
      stroke(x*360 div width,y/height,1.0)
      setPixel(x,y)

  endPixels()

run(600, 400, draw, setup)