import times
import drawim/transform, drawim/shapes, drawim/colors
when not defined(js):
  import drawim/backends/opengl_backend as backend

type ColorMode* = colors.ColorMode
type ArcMode* = shapes.ArcMode

var height* = 0
var width* = 0
var frameCount* = 0
var time, deltaTime*: float = 0.0

proc background*(r,g,b: int | float) = colors.background(r,g,b)
proc background*(gray: int | float) = colors.background(gray)

proc stroke*(r,g,b: int | float) = colors.stroke(r,g,b)
proc stroke*(r,g,b,a: int | float) = colors.stroke(r,g,b,a)
proc stroke*(gray: int | float) = colors.stroke(gray)
proc stroke*(hex: string) = colors.stroke(hex)
proc noStroke*() = colors.stroke(0,0,0,0)

proc fill*(r,g,b: int | float) = colors.fill(r,g,b)
proc fill*(r,g,b, a: int | float) = colors.fill(r,g,b, a)
proc fill*(gray: int | float) = colors.fill(gray)
proc fill*(hex: string) = colors.fill(hex)
proc noFill*() = colors.fill(0,0,0,0)

proc setColorMode*(mode: ColorMode) = colors.setColorMode(mode)

proc rotate*(theta: SomeNumber) = transform.rotate(theta)
proc translate*(x,y: SomeNumber) = transform.translate(x,y)
proc scale*(x,y: SomeNumber) = transform.scale(x,y)
proc push*() = transform.push()
proc pop*() = transform.pop()

proc beginPath*() = shapes.beginPath()
proc beginShape*() = shapes.beginShape()
proc beginFilledShape*() = shapes.beginFilledShape()
proc beginPixels*() = shapes.beginPixels()
proc endPath*() = shapes.endPath()
proc endShape*() = shapes.endShape()
proc endFilledShape*() = shapes.endFilledShape()
proc endPixels*() = shapes.endPixels()
proc vertex*(x,y: SomeNumber) = shapes.vertex(x,y)
proc setPixel*(x,y: SomeNumber) = shapes.setPixel(x,y)

proc rect*(x,y,w,h: SomeNumber) = shapes.rect(x,y,w,h)
proc rectFill*(x,y,w,h: SomeNumber) = shapes.rectFill(x,y,w,h)
proc triangle*(x1,y1,x2,y2,x3,y3: SomeNumber) = shapes.triangle(x1,y1,x2,y2,x3,y3)
proc triangleFill*(x1,y1,x2,y2,x3,y3: SomeNumber) = shapes.triangleFill(x1,y1,x2,y2,x3,y3)
proc arc*(cx, cy, rx, ry: SomeNumber, beginAngle, endAngle: float, mode: ArcMode = Open) = shapes.arc(cx, cy, rx, ry, beginAngle, endAngle, mode)
proc arcFill*(cx, cy, rx, ry: SomeNumber, beginAngle, endAngle: float, mode: ArcMode = Open) = shapes.arcFill(cx, cy, rx, ry, beginAngle, endAngle, mode)
proc ellipse*(cx, cy, rx, ry: SomeNumber) = shapes.ellipse(cx, cy, rx, ry)
proc ellipseFill*(cx, cy, rx, ry: SomeNumber) = shapes.ellipseFill(cx, cy, rx, ry)
proc circle*(cx, cy, r: SomeNumber) = shapes.circle(cx, cy, r)
proc circleFill*(cx, cy, r: SomeNumber) = shapes.circleFill(cx, cy, r)
proc line*(x1, y1,x2, y2: SomeNumber) = shapes.line(x1, y1, x2, y2)

proc run*(w, h: int, draw: proc(), setup: proc() = proc() = discard, name: string = "Drawim") =
  backend.initialize(name, w, h)
  width = w
  height = h
  time = epochTime()

  setup()
  while backend.isRunning():
    resetTransform()
    frameCount += 1

    deltaTime = epochTime() - time
    time = epochTime()

    draw()

    backend.afterDraw()

  backend.terminate()
