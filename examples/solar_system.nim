import ../src/drawim

var theta = 0.0
proc draw() =
  theta += 0.01
  background(20);
  translate(int(width / 2),int(height / 2))
  # Draw the sun
  fill(200,200,20)
  circleFill(0,0,50)

  rotate(theta)
  translate(150,0)
  # Draw the earth
  fill(20,20,200)
  circleFill(0,0,15)

  rotate(theta)
  translate(40,0)
  # Draw the moon
  fill(200,200,200)
  circleFill(0,0,5)


run(600, 400, draw)
