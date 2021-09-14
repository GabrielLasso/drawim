import std/times
import drawim/transform, drawim/shapes, drawim/colors, drawim/inputs
when defined(js):
  import drawim/backends/js_backend as backend
else:
  import drawim/backends/opengl_backend as backend

export colors, shapes, inputs
export transform except resetTransform, getScreenPosition, getRealPosition

var height* = 0
var width* = 0
var frameCount* = 0
var time, deltaTime*: float = 0.0

proc setFrameRate*(frameRate: int) = backend.setFrameRate(frameRate)

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
