import drawim

proc draw() =
  let theta = frameCount / 100
  background(20)
  translate(width div 2, height div 2)
  # Draw the sun
  fill(200, 200, 20)
  circleFill(0, 0, 50)

  rotate(theta)
  translate(150, 0)
  # Draw the earth
  fill(20, 20, 200)
  circleFill(0, 0, 15)

  rotate(theta)
  translate(40, 0)
  # Draw the moon
  fill(200)
  circleFill(0, 0, 5)

run(600, 400, draw)
