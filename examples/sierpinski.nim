import ../src/drawim
import math

proc sierpinski(x1,y1,x2,y2,x3,y3: float) =
  if ((abs(x1 - x2) < 3 and abs(y1 - y2) < 3) or 
      (abs(x1 - x3) < 3 and abs(y1 - y3) < 3) or 
      (abs(x2 - x3) < 3 and abs(y2 - y3) < 3)):
    triangle(x1, y1, x2, y2, x3, y3)
  else:
    sierpinski(x1, y1, (x1+x2) / 2, (y1+y2) / 2, (x1+x3) / 2, (y1+y3) / 2)
    sierpinski((x1+x2) / 2, (y1+y2) / 2, x2, y2, (x2+x3) / 2, (y2+y3) / 2)
    sierpinski((x1+x3) / 2, (y1+y3) / 2, (x2+x3) / 2, (y2+y3) / 2, x3, y3)

proc draw() =
  background(250)
  translate(int(width / 2),int(height / 2))
  rotate(PI)

  sierpinski(0.0, 100.0, 86.0, -50.0, -86.0, -50.0)


run(600, 400, draw)