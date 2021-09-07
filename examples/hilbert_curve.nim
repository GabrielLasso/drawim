import drawim
import math

proc hilbert_curve(x1, y1, x2, y2, x3, y3, x4, y4: int, max_depth = 6) =
  if (max_depth < 1):
    vertex((3*x1+x3) div 4, (3*y1+y3) div 4)
    vertex((3*x2+x4) div 4, (3*y2+y4) div 4)
    vertex((3*x3+x1) div 4, (3*y3+y1) div 4)
    vertex((3*x4+x2) div 4, (3*y4+y2) div 4)
  else:
    hilbert_curve(x1, y1, (x1+x4) div 2, (y1+y4) div 2, (x1+x2+x3+x4) div 4, (
        y1+y2+y3+y4) div 4, (x1+x2) div 2, (y1+y2) div 2, max_depth - 1)
    hilbert_curve((x1+x2) div 2, (y1+y2) div 2, x2, y2, (x2+x3) div 2, (
        y2+y3) div 2, (x1+x2+x3+x4) div 4, (y1+y2+y3+y4) div 4, max_depth - 1)
    hilbert_curve((x1+x2+x3+x4) div 4, (y1+y2+y3+y4) div 4, (x2+x3) div 2, (
        y2+y3) div 2, x3, y3, (x3+x4) div 2, (y3+y4) div 2, max_depth - 1)
    hilbert_curve((x3+x4) div 2, (y3+y4) div 2, (x1+x2+x3+x4) div 4, (
        y1+y2+y3+y4) div 4, (x1+x4) div 2, (y1+y4) div 2, x4, y4, max_depth - 1)

var
  x1 = -200
  x2 = 200
  x3 = 200
  x4 = -200
  y1 = -200
  y2 = -200
  y3 = 200
  y4 = 200

proc draw() =
  background(250)
  stroke("#FF5555")
  translate(300, 300)
  let zoomX = 300/sqrt(float(mouseX()*mouseX() + mouseY()*mouseY()))
  let zoomY = 300/sqrt(float(mouseX()*mouseX() + mouseY()*mouseY()))
  scale(zoomX, zoomY)
  beginPath()
  hilbert_curve(x1, y1, x2, y2, x3, y3, x4, y4)
  endPath()

run(600, 600, draw)
