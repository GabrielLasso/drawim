import drawim

proc draw() =
  background(200)
  stroke(40)

  bezier(60, 60, 90, 180, 270, 60, 300, 180)

  beginPath()
  vertex(400, 230)
  bezierVertex(460, 230, 500, 250, 500, 300)
  bezierVertex(500, 320, 520, 350, 400, 350)
  bezierVertex(300, 350, 400, 300, 400, 270)
  bezierVertex(400, 240, 300, 230, 400, 230)
  endPath()

run(600, 400, draw)
