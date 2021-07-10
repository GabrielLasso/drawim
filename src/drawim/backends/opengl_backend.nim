import opengl, staticglfw

var window_width: int
var window_height: int
var window: Window
var mouseX, mouseY: int

# Maps (0,0) to (-1, 1) and (window_width, window_height) to (1, -1)
proc getGlCoords(x, y: int): (float, float) =
  let new_x = 2 * (float(x) - window_width/2)/float(window_width)
  let new_y = -2 * (float(y) - window_height/2)/float(window_height)
  return (new_x, new_y)

proc changeColor*(r, g, b: float) =
  glColor3f(r, g, b)

proc drawPolygonFill*(vertices: seq[(int, int)]) =
  glBegin(GL_POLYGON)

  for (x, y) in vertices:
    let (glX, glY) = getGlCoords(x,y)
    glVertex2f(glX, glY)

  glEnd()

proc drawPolygon*(vertices: seq[(int, int)]) =
  glBegin(GL_LINE_LOOP)

  for (x, y) in vertices:
    let (glX, glY) = getGlCoords(x,y)
    glVertex2f(glX, glY)

  glEnd()

proc drawLines*(vertices: seq[(int, int)]) =
  glBegin(GL_LINES)

  for (x, y) in vertices:
    let (glX, glY) = getGlCoords(x,y)
    glVertex2f(glX, glY)

  glEnd()

proc background*(r,g,b: float) =
  glClearColor(r, g, b, 1)
  glClear(GL_COLOR_BUFFER_BIT)

let cursorPos: CursorPosFun = proc(window: Window, x, y: cdouble) {.cdecl.} =
  mouseX = int(x)
  mouseY = int(y)

proc getCursorPos*(): (int, int) = (mouseX, mouseY)

proc initialize*(name: string, w, h: int) =
  if init() == 0:
    quit("Failed to Initialize GLFW.")

  windowHint(RESIZABLE, false.cint)
  
  window = createWindow(cint(w), cint(h), name, nil, nil)
  window_width = w
  window_height = h

  discard window.setCursorPosCallback(cursorPos)

  makeContextCurrent(window)
  loadExtensions()
  glColor3i(0, 0, 0)

proc afterDraw*() =
  window.swapBuffers()
  glReadBuffer(GL_FRONT);
  glDrawBuffer(GL_BACK);
  glCopyPixels(0, 0, GLsizei(window_width), GLsizei(window_height), GL_COLOR)
  pollEvents()

proc terminate*() =
  window.destroyWindow()
  staticglfw.terminate()

proc isRunning*(): bool = windowShouldClose(window) != 1