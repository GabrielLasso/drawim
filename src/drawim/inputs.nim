import transform, constants/keycodes

export keycodes except getKeyCode, getMouseButtonCode

when defined(js):
  import backends/js_backend as backend
else:
  import backends/opengl_backend as backend

proc getMousePosition(): (int, int) = transform.getRealPosition(
    backend.getCursorPos()[0], backend.getCursorPos()[1])
proc mouseX*(): int = getMousePosition()[0]
proc mouseY*(): int = getMousePosition()[1]
proc isKeyPressed*(key: Key): bool = backend.isKeyPressed(getKeyCode(key))
proc isMousePressed*(btn: MouseButton): bool = backend.isMousePressed(getMouseButtonCode(btn))
