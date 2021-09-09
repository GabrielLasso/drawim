import drawim, std/math

proc setup() =
  background(220)

proc draw() =
  stroke(0, 0, 0)
  fill(255, 255, 0)
  arcFill(300, 200, 150, 150, Pi / 4, 7*Pi/4, ArcMode.Pie)

run(600, 400, draw, setup)
