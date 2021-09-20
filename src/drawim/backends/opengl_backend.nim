import opengl, staticglfw, std/[times, os], tables, sequtils

var windowWidth: int
var windowHeight: int
var window: Window
var mouseX, mouseY: int
var pixelDensityX, pixelDensityY: int

var frameRate = 60
var lastTime: float

let keyStates: ref Table[cint, bool] = newTable[cint, bool]()
let btnStates: ref Table[cint, bool] = newTable[cint, bool]()

var keysToClear: seq[cint] = newSeq[cint]()
var mouseButtonsToClear: seq[cint] = newSeq[cint]()

# Maps (0,0) to (-1, 1) and (windowWidth, windowHeight) to (1, -1)
proc getGlCoords(x, y: int): (float, float) =
  let new_x = 2 * (float(x) - windowWidth/2)/float(windowWidth)
  let new_y = -2 * (float(y) - windowHeight/2)/float(windowHeight)
  return (new_x, new_y)

proc drawFilledPolygon*(vertices: seq[(int, int)]) =
  glBegin(GL_POLYGON)
  for (x, y) in vertices:
    let (glX, glY) = getGlCoords(x, y)
    glVertex2f(glX, glY)
  glEnd()

proc drawPolygon*(vertices: seq[(int, int)]) =
  glBegin(GL_LINE_LOOP)
  for (x, y) in vertices:
    let (glX, glY) = getGlCoords(x, y)
    glVertex2f(glX, glY)
  glEnd()

proc drawPath*(vertices: seq[(int, int)]) =
  glBegin(GL_LINE_STRIP)
  for (x, y) in vertices:
    let (glX, glY) = getGlCoords(x, y)
    glVertex2f(glX, glY)
  glEnd()

proc beginPixels*() =
  glBegin(GL_POINTS)

proc endPixels*() =
  glEnd()

proc setPixel*(x, y: int) =
  let (glX, glY) = getGlCoords(x, y)
  glVertex2f(glX, glY)

proc background*(r, g, b, a: float) =
  glClearColor(r, g, b, a)
  glClear(GL_COLOR_BUFFER_BIT)

proc changeColor*(r, g, b, a: float) =
  glColor4f(r, g, b, a)

let cursorPos: CursorPosFun = proc(window: Window, x, y: cdouble) {.cdecl.} =
  mouseX = int(x)
  mouseY = int(y)

let keyCallback: KeyFun = proc(window: Window, key: cint, scancode: cint, action: cint, modifiers: cint) {.cdecl.} =
  if action == PRESS:
    keyStates[key] = true
  elif action == RELEASE:
    keysToClear.insert(key)

let mouseButtonCallback: MouseButtonFun = proc (window: Window, button: cint, action: cint, modifiers: cint) {.cdecl.} =
  if action == PRESS:
    btnStates[button] = true
  elif action == RELEASE:
    mouseButtonsToClear.insert(button)

proc getCursorPos*(): (int, int) = (mouseX, mouseY)

proc isKeyPressed*(key: int): bool =
  result = keyStates.hasKey(cint(key)) and keyStates[cint(key)]

proc isMousePressed*(btn: int): bool =
  result = btnStates.hasKey(cint(btn)) and btnStates[cint(btn)]

proc setFrameRate*(newFrameRate: int) =
  frameRate = newFrameRate

proc initialize(name: string, w, h: cint) =
  if init() == 0:
    quit("Failed to Initialize GLFW.")

  windowHint(RESIZABLE, false.cint)

  window = createWindow(cint(w), cint(h), name, nil, nil)

  windowWidth = w
  windowHeight = h

  var bufferWidth, bufferHeight:cint
  window.getFramebufferSize(addr(bufferWidth), addr(bufferHeight))
  pixelDensityX = bufferWidth div windowWidth
  pixelDensityY = bufferWidth div windowHeight

  discard window.setCursorPosCallback(cursorPos)
  discard window.setKeyCallback(keyCallback)
  discard window.setMouseButtonCallback(mouseButtonCallback)

  makeContextCurrent(window)
  loadExtensions()
  glEnable(GL_BLEND)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
  swapInterval(0)
  lastTime = epochTime()

proc afterDraw() =
  for key in keysToClear:
    keyStates[key] = false
  if keysToClear.len > 0:
    keysToClear.delete(0, keysToClear.len - 1)

  for btn in mouseButtonsToClear:
    btnStates[btn] = false
  if mouseButtonsToClear.len > 0:
    mouseButtonsToClear.delete(0, mouseButtonsToClear.len - 1)

  window.swapBuffers()
  glReadBuffer(GL_FRONT)
  glDrawBuffer(GL_BACK)
  glCopyPixels(0, 0, GLsizei(windowWidth * pixelDensityX), GLsizei(windowHeight * pixelDensityY), GL_COLOR)
  pollEvents()

  while epochTime() - lastTime < 1 / frameRate:
    os.sleep(1)
  lastTime = epochTime()

proc terminate() =
  window.destroyWindow()
  staticglfw.terminate()

proc isRunning(): bool = windowShouldClose(window) != 1

proc run*(w, h: int, draw: proc(), setup: proc(), name: string) =
  initialize(name, cint(w), cint(h))
  setup()
  while isRunning():
    draw()
    afterDraw()
  terminate()
