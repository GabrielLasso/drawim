import math
when not defined(js):
  import drawim/backends/opengl_backend as backend

var height* = 0
var width* = 0

var fillColor: (float, float, float) = (1.0, 1.0, 1.0)
var strokeColor: (float, float, float) = (0.0, 0.0, 0.0)

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
  fillColor = (r, g, b)
  backend.changeColor(r, g, b)

proc fill*(r, g, b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  fillColor = (r_f, g_f, b_f)
  backend.changeColor(r_f, g_f, b_f)

proc fill*(gray: int | float) =
  fill(gray, gray, gray)

proc stroke*(r, g, b: float) =
  strokeColor = (r, g, b)

proc stroke*(r, g, b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  strokeColor = (r_f, g_f, b_f)

proc stroke*(gray: int | float) =
  stroke(gray, gray, gray)

proc setStrokeColor() =
  backend.changeColor(strokeColor[0], strokeColor[1], strokeColor[2])
proc setFillColor() =
  backend.changeColor(fillColor[0], fillColor[1], fillColor[2])

proc rect*(x,y,w,h: int) =
  setStrokeColor()
  backend.drawPolygon(@[
    getRealPosition(x,y),
    getRealPosition(x, y+h),
    getRealPosition(x+w, y+h),
    getRealPosition(x+w, y)
  ])

proc rectFill*(x,y,w,h: int) =
  setFillColor()
  backend.drawPolygonFill(@[
    getRealPosition(x,y),
    getRealPosition(x, y+h),
    getRealPosition(x+w, y+h),
    getRealPosition(x+w, y)
  ])
  rect(x,y,w,h)

proc line*(x1,y1,x2,y2: int) =
  setStrokeColor()
  backend.drawLines(@[
    getRealPosition(x1,y1),
    getRealPosition(x2, y2)
  ])

proc ellipse*(cx, cy, rx, ry: int) =
  setStrokeColor()
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

proc ellipseFill*(cx, cy, rx, ry: int) =
  setFillColor()
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
  ellipse(cx, cy, rx, ry)

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


proc run*(w, h: int, draw: proc(), setup: proc() = proc() = discard, name: string = "Drawim") =
  backend.initialize(name, w, h)
  width = w
  height = h

  setup()
  while backend.isRunning():
    coordinates.rotation = 0.0
    coordinates.sin_rotation = 0.0
    coordinates.cos_rotation = 1.0
    coordinates.ox = 0
    coordinates.oy = 0

    draw()

    backend.afterDraw()

  backend.terminate()
