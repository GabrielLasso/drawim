import drawim, std/math

proc branch(len: int) =
  if (len < 1):
    return
  line(0, 0, 0, len)

  push()
  translate(0, len)
  rotate(PI / 6)
  branch(int(float(len)*0.7))
  pop()

  push()
  translate(0, len)
  rotate(-PI / 6)
  branch(int(float(len)*0.7))
  pop()

proc draw() =
  background(200)
  stroke(30, 150, 15)
  translate(int(width / 2), height)
  rotate(PI)

  branch(100)

run(600, 400, draw)
