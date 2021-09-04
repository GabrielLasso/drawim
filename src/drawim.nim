import times
import drawim/transform, drawim/shapes, drawim/colors, drawim/inputs
when not defined(js):
  import drawim/backends/opengl_backend as backend
when defined(js):
  import drawim/backends/js_backend as backend

include drawim/constants/keycodes

type ColorMode* = colors.ColorMode
type ArcMode* = shapes.ArcMode

var height* = 0
var width* = 0
var frameCount* = 0
var time, deltaTime*: float = 0.0

proc background*(rh, gs, bv: SomeNumber) = colors.background(rh, gs, bv)
proc background*(gray: SomeNumber) = colors.background(gray)

proc stroke*(rh, gs, bv: SomeNumber) = colors.stroke(rh, gs, bv)
proc stroke*(rh, gs, bv, a: SomeNumber) = colors.stroke(rh, gs, bv, a)
proc stroke*(gray: SomeNumber) = colors.stroke(gray)
proc stroke*(hex: string) = colors.stroke(hex)
proc noStroke*() = colors.stroke(0, 0, 0, 0)

proc fill*(rh, gs, bv: SomeNumber) = colors.fill(rh, gs, bv)
proc fill*(rh, gs, bv, a: SomeNumber) = colors.fill(rh, gs, bv, a)
proc fill*(gray: SomeNumber) = colors.fill(gray)
proc fill*(hex: string) = colors.fill(hex)
proc noFill*() = colors.fill(0, 0, 0, 0)

proc setColorMode*(mode: ColorMode) = colors.setColorMode(mode)

proc rotate*(theta: SomeNumber) = transform.rotate(theta)
proc translate*(x, y: SomeNumber) = transform.translate(x, y)
proc scale*(x, y: SomeNumber) = transform.scale(x, y)
proc push*() = transform.push()
proc pop*() = transform.pop()

proc beginPath*() = shapes.beginPath()
proc beginShape*() = shapes.beginShape()
proc beginFilledShape*() = shapes.beginFilledShape()
proc endPath*() = shapes.endPath()
proc endShape*() = shapes.endShape()
proc endFilledShape*() = shapes.endFilledShape()
proc vertex*(x, y: SomeNumber) = shapes.vertex(x, y)

proc beginPixels*() = shapes.beginPixels()
proc endPixels*() = shapes.endPixels()
proc setPixel*(x, y: SomeNumber) = shapes.setPixel(x, y)

proc rect*(x, y, w, h: SomeNumber) = shapes.rect(x, y, w, h)
proc rectFill*(x, y, w, h: SomeNumber) = shapes.rectFill(x, y, w, h)
proc triangle*(x1, y1, x2, y2, x3, y3: SomeNumber) = shapes.triangle(x1, y1, x2,
    y2, x3, y3)
proc triangleFill*(x1, y1, x2, y2, x3, y3: SomeNumber) = shapes.triangleFill(x1,
    y1, x2, y2, x3, y3)
proc arc*(cx, cy, rx, ry: SomeNumber, beginAngle, endAngle: float,
    mode: ArcMode = Open) = shapes.arc(cx, cy, rx, ry, beginAngle, endAngle, mode)
proc arcFill*(cx, cy, rx, ry: SomeNumber, beginAngle, endAngle: float,
    mode: ArcMode = Open) = shapes.arcFill(cx, cy, rx, ry, beginAngle, endAngle, mode)
proc ellipse*(cx, cy, rx, ry: SomeNumber) = shapes.ellipse(cx, cy, rx, ry)
proc ellipseFill*(cx, cy, rx, ry: SomeNumber) = shapes.ellipseFill(cx, cy, rx, ry)
proc circle*(cx, cy, r: SomeNumber) = shapes.circle(cx, cy, r)
proc circleFill*(cx, cy, r: SomeNumber) = shapes.circleFill(cx, cy, r)
proc line*(x1, y1, x2, y2: SomeNumber) = shapes.line(x1, y1, x2, y2)
proc bezier*(x1, y1, x2, y2, x3, y3, x4, y4: SomeNumber) = shapes.bezier(x1, y1, x2, y2, x3, y3, x4, y4)

proc mouseX*(): int = inputs.mouseX()
proc mouseY*(): int = inputs.mouseY()
proc isKeyPressed*(key: int): bool = inputs.isKeyPressed(key)
proc isMousePressed*(btn: int): bool = inputs.isMousePressed(btn)

proc drawWrapper(draw: proc()): proc() =
  return proc() =
    resetTransform()
    frameCount += 1
    deltaTime = epochTime() - time
    time = epochTime()

    draw()

proc run*(w, h: int, draw: proc(), setup: proc() = proc() = discard,
    name: string = "Drawim") = 
  width = w
  height = h
  time = epochTime()

  backend.run(w, h, drawWrapper(draw), setup, name)

