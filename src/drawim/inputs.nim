import transform

when defined(js):
  import backends/js_backend as backend
else:
  import backends/opengl_backend as backend

proc getMousePosition(): (int, int) = transform.getRealPosition(
    backend.getCursorPos()[0], backend.getCursorPos()[1])
proc mouseX*(): int = getMousePosition()[0]
proc mouseY*(): int = getMousePosition()[1]
proc isKeyPressed*(key: int): bool = backend.isKeyPressed(key)
proc isMousePressed*(btn: int): bool = backend.isMousePressed(btn)
