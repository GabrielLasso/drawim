import std/[dom, strformat], jscanvas, sequtils

var canvas: CanvasElement
var context: CanvasContext

var pixels: ImageData

var strokeColor: array[4, uint8]
var fillColor: array[4, uint8]

var mouseX, mouseY: int

var keys: array[256, bool]
var mouseButtons: array[8, bool]
var keysToClear: seq[int] = newSeq[int]()
var mouseButtonsToClear: seq[int] = newSeq[int]()

var frameRate = 60

proc drawFilledPolygon*(vertices: seq[(int, int)]) =
  context.fillStyle = &"rgba({fillColor[0]}, {fillColor[1]}, {fillColor[2]}, {int(strokeColor[3])/255})"
  context.beginPath()
  for (x, y) in vertices:
    context.lineTo(x, y)

  context.closePath()
  context.fill()

proc drawPolygon*(vertices: seq[(int, int)]) =
  context.strokeStyle = &"rgba({strokeColor[0]}, {strokeColor[1]}, {strokeColor[2]}, {int(strokeColor[3])/255})"
  context.beginPath()
  for (x, y) in vertices:
    context.lineTo(x, y)

  context.closePath()
  context.stroke()

proc drawPath*(vertices: seq[(int, int)]) =
  context.strokeStyle = fmt"rgba({strokeColor[0]}, {strokeColor[1]}, {strokeColor[2]}, {int(strokeColor[3])/255})"
  context.beginPath()
  for (x, y) in vertices:
    context.lineTo(x, y)
  context.stroke()

proc beginPixels*() =
  pixels = context.getImageData(0, 0, canvas.width, canvas.height)

proc endPixels*() =
  context.putImageData(pixels, 0, 0)

proc setPixel*(x, y: int) =
  let row = y * canvas.width * 4;
  let pos = row + x * 4;
  pixels.data[pos] = strokeColor[0]
  pixels.data[pos + 1] = strokeColor[1]
  pixels.data[pos + 2] = strokeColor[2]
  pixels.data[pos + 3] = strokeColor[3]

proc background*(r, g, b, a: float) =
  context.clearRect(0, 0, canvas.width, canvas.height)
  context.fillStyle = &"rgba({r*255}, {g*255}, {b*255}, {a*255})"
  context.fillRect(0, 0, canvas.width, canvas.height)

proc changeColor*(r, g, b, a: float) =
  strokeColor = [uint8(r*255), uint8(g*255), uint8(b*255), uint8(a*255)]
  fillColor = [uint8(r*255), uint8(g*255), uint8(b*255), uint8(a*255)]

let updateMousePos = proc (e: Event) =
  let event = e.MouseEvent
  mouseX = event.clientX - canvas.offsetLeft + int(window.scrollX)
  mouseY = event.clientY - canvas.offsetTop + int(window.scrollY)

window.addEventListener("mousemove", updateMousePos)

let keydown = proc (e: Event) =
  let event = e.KeyboardEvent
  keys[event.keyCode] = true

let keyup = proc (e: Event) =
  let event = e.KeyboardEvent
  keysToClear.insert(event.keyCode)

document.addEventListener("keydown", keydown)
document.addEventListener("keyup", keyup)

let mousedown = proc (e: Event) =
  let event = e.MouseEvent
  mouseButtons[event.button] = true

let mouseup = proc (e: Event) =
  let event = e.MouseEvent
  mouseButtonsToClear.insert(event.button)

document.addEventListener("mousedown", mousedown)
document.addEventListener("mouseup", mouseup)

proc getCursorPos*(): (int, int) =
  return (mouseX, mouseY)

proc isKeyPressed*(key: int): bool =
  keys[key]

proc isMousePressed*(btn: int): bool =
  mouseButtons[btn]

proc setFrameRate*(newFrameRate: int) =
    frameRate = newFrameRate

proc initialize*(name: string, w, h: int) =
  window.onload = proc(e: Event) =
    let root = document.getElementById(name)
    canvas = document.createElement("canvas").CanvasElement
    canvas.width = w
    canvas.height = h
    root.appendChild(canvas)
    context = canvas.getContext2d()

proc drawAndClearInput(draw: proc()): proc() =
  result = proc() =
    draw()
    for key in keysToClear:
      keys[key] = false
    if keysToClear.len > 0:
      keysToClear.delete(0, keysToClear.len - 1)

    for btn in mouseButtonsToClear:
      mouseButtons[btn] = false
    if mouseButtonsToClear.len > 0:
      mouseButtonsToClear.delete(0, mouseButtonsToClear.len - 1)

proc run*(w, h: int, draw: proc(), setup: proc(), name: string) =
  initialize(name, w, h)
  discard setTimeout(setup, 0)
  var recursion: proc()
  let drawFrame = drawAndClearInput(draw)
  recursion = proc() =
    discard setTimeout(recursion, 1000 div frameRate)
    discard setTimeout(drawFrame, 0)
  discard setTimeout(recursion, 0)
