import ../src/drawim

proc setup() =
  setColorMode(ColorMode.HSV)

proc draw() =
  beginPoints()
  for x in 0..<width:
    for y in 0..<height:
      stroke(x*360 div width,y/height,1.0)
      vertex(x,y)

  endPoints()

run(600, 400, draw, setup)