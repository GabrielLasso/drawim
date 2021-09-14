import drawim

proc draw() =
  background(255)
  stroke(0)
  translate(width/2, height/2)
  scale(100, -100)
  beginPath()
  for x in -width div 2..width div 2:
    let scaledX = x/100
    vertex(scaledX, scaledX*scaledX*scaledX)
  endPath()

run(300, 625, draw)