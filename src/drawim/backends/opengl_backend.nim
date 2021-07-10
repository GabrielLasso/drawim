import opengl, staticglfw, math

var window_width: int
var window_height: int
var window: Window

var rotation = 0.0
var sin_rotation = 0.0
var cos_rotation = 1.0

# Maps (0,0) to (-1, 1) and (window_width, window_height) to (1, -1)
proc getGlCoords(x, y: int): (float, float) =
  let x_rot = float(x)*cos_rotation - float(y)*sin_rotation
  let y_rot = float(x)*sin_rotation + float(y)*cos_rotation
  let new_x = 2 * (x_rot - window_width/2)/float(window_width)
  let new_y = -2 * (y_rot - window_height/2)/float(window_height)
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

proc rotate*(theta: float) =
  rotation = theta
  sin_rotation = sin(rotation)
  cos_rotation = cos(rotation)

proc initialize*(name: string, w, h: int) =
  if init() == 0:
    quit("Failed to Initialize GLFW.")

  windowHint(RESIZABLE, false.cint)
  
  window = createWindow(cint(w), cint(h), name, nil, nil)
  window_width = w
  window_height = h

  makeContextCurrent(window)
  loadExtensions()

proc afterDraw*() =
  window.swapBuffers()
  pollEvents()

proc terminate*() =
  window.destroyWindow()
  staticglfw.terminate()

proc isRunning*(): bool = windowShouldClose(window) != 1