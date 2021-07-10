import math
when not defined(js):
  import drawim/backends/opengl_backend as backend

proc rgbIntToFloat(r,g,b: int): (float, float, float) =
  return (r/255, g/255, b/255)

proc fill*(r, g, b: float) =
  backend.changeColor(r, g, b)

proc fill*(r, g, b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  backend.changeColor(r_f, g_f, b_f)

proc fill*(gray: int | float) =
  fill(gray, gray, gray)

proc rectFill*(x,y,w,h: int) =
  backend.drawPolygonFill(@[
    (x,y),
    (x, y+h),
    (x+w, y+h),
    (x+w, y)
  ])

proc rect*(x,y,w,h: int) =
  backend.drawPolygon(@[
    (x,y),
    (x, y+h),
    (x+w, y+h),
    (x+w, y)
  ])

proc line*(x1,y1,x2,y2: int) =
  backend.drawLines(@[
    (x1,y1),
    (x2, y2)
  ])

proc ellipseFill*(cx, cy, rx, ry: int) =
  const num_segments = 512
  let theta = 2 * PI / num_segments
  let c = cos(theta)
  let s = sin(theta)
  var x = 1.0
  var y = 0.0
  var vertices: seq[(int, int)]

  for i in 0..<num_segments:
    vertices.add((int(x * float(rx) + float(cx)), int(y * float(ry) + float(cy))))
    let t = x;
    x = c * x - s * y;
    y = s * t + c * y;
  backend.drawPolygonFill(vertices)

proc ellipse*(cx, cy, rx, ry: int) =
  const num_segments = 512
  let theta = 2 * PI / num_segments
  let c = cos(theta)
  let s = sin(theta)
  var x = 1.0
  var y = 0.0
  var vertices: seq[(int, int)]

  for i in 0..<num_segments:
    vertices.add((int(x * float(rx) + float(cx)), int(y * float(ry) + float(cy))))
    let t = x;
    x = c * x - s * y;
    y = s * t + c * y;
  backend.drawPolygon(vertices)

proc background*(r,g,b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  backend.background(r_f,g_f,b_f)

proc background*(r,g,b: float) =
  backend.background(r,g,b)

proc background*(gray: float | int) =
  background(gray, gray, gray)

proc rotate*(theta: float) = 
  backend.rotate(theta)

proc translate*(x, y: int) = 
  backend.translate(x,y)

proc run*(w, h: int, draw: proc(), name: string = "Drawim") =
  backend.initialize(name, w, h)

  while backend.isRunning():
    draw()

    backend.afterDraw()

  backend.terminate()
