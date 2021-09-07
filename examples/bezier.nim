import drawim

proc draw() =
  background(200)
  stroke(40)

  bezier(100, 100, 150, 300, 450, 100, 500, 300)

run(600, 400, draw)