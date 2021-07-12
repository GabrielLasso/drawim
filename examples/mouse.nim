import ../src/drawim
import ../src/drawim/inputs

proc setup() =
  background(220)

proc draw() =
  fill(255,255,255,200)
  if isMousePressed(MOUSE_BUTTON_LEFT):
    circleFill(mouseX(), mouseY(), 20)

  if isKeyPressed(KEY_ESCAPE):
    background(220)

run(600, 400, draw, setup)
