import math
import colors, transform
when not defined(js):
  import backends/opengl_backend as backend

type
  DrawKinds = enum Shape, FilledShape, Path
  Draw = object
    vertices: seq[(int, int)]
    drawKind: DrawKinds

var drawingStack = newSeq[Draw]()

proc newShape(): Draw = Draw(drawKind: Shape)
proc newFilledShape(): Draw = Draw(drawKind: FilledShape)
proc newPath(): Draw = Draw(drawKind: Path)

proc beginPath*() =
  drawingStack.add(newPath())

proc beginShape*() =
  drawingStack.add(newShape())

proc beginFilledShape*() =
  drawingStack.add(newFilledShape())

proc endShape*() =
  let vertices = drawingStack[^1].vertices
  drawingStack.setLen(drawingStack.len - 1)
  setStrokeColor()
  backend.drawPolygon(vertices)

proc endFilledShape*() =
  let vertices = drawingStack[^1].vertices
  drawingStack.setLen(drawingStack.len - 1)
  setStrokeColor()
  backend.drawPolygon(vertices)
  setFillColor()
  backend.drawFilledPolygon(vertices)

proc endPath*() =
  let vertices = drawingStack[^1].vertices
  drawingStack.setLen(drawingStack.len - 1)
  setStrokeColor()
  backend.drawPath(vertices)

proc vertex*(x,y: SomeNumber) =
  let (realX, realY) = getScreenPosition(x,y)
  drawingStack[^1].vertices.add((realX, realY))

proc rect*(x,y,w,h: SomeNumber) =
  beginShape()
  vertex(x,y)
  vertex(x, y+h)
  vertex(x+w, y+h)
  vertex(x+w, y)
  endShape()

proc rectFill*(x,y,w,h: SomeNumber) =
  beginFilledShape()
  vertex(x,y)
  vertex(x, y+h)
  vertex(x+w, y+h)
  vertex(x+w, y)
  endFilledShape()

proc triangle*(x1,y1,x2,y2,x3,y3: SomeNumber) =
  beginShape()
  vertex(x1,y1)
  vertex(x2, y2)
  vertex(x3, y3)
  endShape()

proc triangleFill*(x1,y1,x2,y2,x3,y3: SomeNumber) =
  beginFilledShape()
  vertex(x1,y1)
  vertex(x2, y2)
  vertex(x3, y3)
  endFilledShape()

proc line*(x1,y1,x2,y2: SomeNumber) =
  beginPath()
  vertex(x1,y1)
  vertex(x2, y2)
  endPath()

proc ellipse*(cx, cy, rx, ry: SomeNumber) =
  setStrokeColor()
  const num_segments = 512
  let theta = 2 * PI / num_segments
  let c = cos(theta)
  let s = sin(theta)
  var x = 1.0
  var y = 0.0

  beginShape()
  for i in 0..<num_segments:
    vertex(x * float(rx) + float(cx), y * float(ry) + float(cy))
    let t = x;
    x = c * x - s * y;
    y = s * t + c * y;
  endShape()

proc ellipseFill*(cx, cy, rx, ry: SomeNumber) =
  setFillColor()
  const num_segments = 512
  let theta = 2 * PI / num_segments
  let c = cos(theta)
  let s = sin(theta)
  var x = 1.0
  var y = 0.0

  beginFilledShape()
  for i in 0..<num_segments:
    vertex(x * float(rx) + float(cx), (y * float(ry) + float(cy)))
    let t = x;
    x = c * x - s * y;
    y = s * t + c * y;
  endFilledShape()

proc circle*(x, y, r: SomeNumber) = ellipse(x, y, r, r)
proc circleFill*(x, y, r: SomeNumber) = ellipseFill(x, y, r, r)
proc square*(x, y, s: SomeNumber) = rect(x, y, s, s)
proc squareFill*(x, y, s: SomeNumber) = rectFill(x, y, s, s)