import ../src/drawim

proc setup() =
  background(220)

proc draw() =
  fill(255)
  circleFill(mouseX(), mouseY(), 20)
  fill(0)
  circle(mouseX(), mouseY(), 20)

run(600, 400, draw, setup)
