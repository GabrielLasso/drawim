import math, strutils
import drawim/coordinates, drawim/shapes, drawim/colors
when not defined(js):
  import drawim/backends/opengl_backend as backend

var height* = 0
var width* = 0
var frameCount* = 0

proc background*(r,g,b: int | float) = colors.background(r,g,b)
proc background*(gray: int | float) = colors.background(gray)

proc stroke*(r,g,b: int | float) = colors.stroke(r,g,b)
proc stroke*(r,g,b, a: int | float) = colors.stroke(r,g,b, a)
proc stroke*(gray: int | float) = colors.stroke(gray)
proc stroke*(hex: string) = colors.stroke(hex)

proc fill*(r,g,b: int | float) = colors.fill(r,g,b)
proc fill*(r,g,b, a: int | float) = colors.fill(r,g,b, a)
proc fill*(gray: int | float) = colors.fill(gray)
proc fill*(hex: string) = colors.fill(hex)

proc rotate*(theta: float) = coordinates.rotate(theta)
proc translate*(x,y: int) = coordinates.translate(x,y)
proc push*() = coordinates.push()
proc pop*() = coordinates.pop()

proc beginPath*() = shapes.beginPath()
proc beginShape*() = shapes.beginShape()
proc beginFilledShape*() = shapes.beginFilledShape()
proc endPath*() = shapes.endPath()
proc endShape*() = shapes.endShape()
proc endFilledShape*() = shapes.endFilledShape()
proc vertex*(x,y: SomeNumber) = shapes.vertex(x,y)

proc rect*(x,y,w,h: SomeNumber) = shapes.rect(x,y,w,h)
proc rectFill*(x,y,w,h: SomeNumber) = shapes.rectFill(x,y,w,h)
proc triangle*(x1,y1,x2,y2,x3,y3: SomeNumber) = shapes.triangle(x1,y1,x2,y2,x3,y3)
proc triangleFill*(x1,y1,x2,y2,x3,y3: SomeNumber) = shapes.triangleFill(x1,y1,x2,y2,x3,y3)
proc ellipse*(cx, cy, rx, ry: SomeNumber) = shapes.ellipse(cx, cy, rx, ry)
proc ellipseFill*(cx, cy, rx, ry: SomeNumber) = shapes.ellipseFill(cx, cy, rx, ry)
proc circle*(cx, cy, r: SomeNumber) = shapes.circle(cx, cy, r)
proc circleFill*(cx, cy, r: SomeNumber) = shapes.circleFill(cx, cy, r)

proc run*(w, h: int, draw: proc(), setup: proc() = proc() = discard, name: string = "Drawim") =
  backend.initialize(name, w, h)
  width = w
  height = h

  setup()
  while backend.isRunning():
    resetCoordinates()
    frameCount += 1

    draw()

    backend.afterDraw()

  backend.terminate()
