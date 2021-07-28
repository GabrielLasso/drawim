import ../src/drawim
import math
proc setup() =
  background(220)

proc draw() =
  background(220)
  stroke(0, 0, 0)
  fill(255, 255, 0)
  arcFill(300, 200, 150, 150, PI / 4, 7*PI/4, ArcMode.Pie)

run(600, 400, draw, setup)
