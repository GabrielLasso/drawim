import math
when not defined(js):
  import drawim/backends/opengl_backend as backend

var height* = 0
var width* = 0

type Coordinates = object
  ox, oy: int
  rotation: float
  sin_rotation: float
  cos_rotation: float

var coordinates = Coordinates(cos_rotation: 1.0)
var coordinatesStack = newSeq[Coordinates]()

proc rgbIntToFloat(r,g,b: int): (float, float, float) =
  return (r/255, g/255, b/255)

proc getRealPosition(x,y: int): (int, int) =
  let x_rot = int(float(coordinates.ox) + float(x)*coordinates.cos_rotation - float(y)*coordinates.sin_rotation)
  let y_rot = int(float(coordinates.oy) + float(x)*coordinates.sin_rotation + float(y)*coordinates.cos_rotation)
  result = (x_rot, y_rot)

proc fill*(r, g, b: float) =
  backend.changeColor(r, g, b)

proc fill*(r, g, b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  backend.changeColor(r_f, g_f, b_f)

proc fill*(gray: int | float) =
  fill(gray, gray, gray)

proc rectFill*(x,y,w,h: int) =
  backend.drawPolygonFill(@[
    getRealPosition(x,y),
    getRealPosition(x, y+h),
    getRealPosition(x+w, y+h),
    getRealPosition(x+w, y)
  ])

proc rect*(x,y,w,h: int) =
  backend.drawPolygon(@[
    getRealPosition(x,y),
    getRealPosition(x, y+h),
    getRealPosition(x+w, y+h),
    getRealPosition(x+w, y)
  ])

proc line*(x1,y1,x2,y2: int) =
  backend.drawLines(@[
    getRealPosition(x1,y1),
    getRealPosition(x2, y2)
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
    vertices.add(getRealPosition(int(x * float(rx) + float(cx)), int(y * float(ry) + float(cy))))
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
    vertices.add(getRealPosition(int(x * float(rx) + float(cx)), int(y * float(ry) + float(cy))))
    let t = x;
    x = c * x - s * y;
    y = s * t + c * y;
  backend.drawPolygon(vertices)

proc circle*(x, y, r: int) = ellipse(x, y, r, r)
proc circleFill*(x, y, r: int) = ellipseFill(x, y, r, r)
proc square*(x, y, s: int) = rect(x, y, s, s)
proc squareFill*(x, y, s: int) = rectFill(x, y, s, s)

proc background*(r,g,b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  backend.background(r_f,g_f,b_f)

proc background*(r,g,b: float) =
  backend.background(r,g,b)

proc background*(gray: float | int) =
  background(gray, gray, gray)

proc rotate*(theta: float) =
  coordinates.rotation += theta
  coordinates.sin_rotation = sin(coordinates.rotation)
  coordinates.cos_rotation = cos(coordinates.rotation)

proc translate*(x,y: int) =
  coordinates.ox += int(float(x)*coordinates.cos_rotation - float(y)*coordinates.sin_rotation)
  coordinates.oy += int(float(x)*coordinates.sin_rotation + float(y)*coordinates.cos_rotation)

proc push*() =
  coordinatesStack.add(coordinates)

proc pop*() =
  if coordinatesStack.len > 0:
    coordinates = coordinatesStack[^1]
    coordinatesStack.setLen(coordinatesStack.len - 1)

proc run*(w, h: int, draw: proc(), name: string = "Drawim") =
  backend.initialize(name, w, h)
  width = w
  height = h

  while backend.isRunning():
    coordinates.rotation = 0.0
    coordinates.sin_rotation = 0.0
    coordinates.cos_rotation = 1.0
    coordinates.ox = 0
    coordinates.oy = 0

    draw()

    backend.afterDraw()

  backend.terminate()
