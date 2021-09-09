import drawim, std/[random, math]

type
  Particle = object
    x, y, vx, vy: float

randomize()

proc newParticle(): Particle =
  result.x = float(rand(width))
  result.y = float(rand(height))
  result.vx = rand(2.0) - 1
  result.vy = rand(2.0) - 1

proc update(particle: var Particle) =
  let ox = width / 2
  let oy = height / 2
  let distSquared = (particle.x - ox) * (particle.x - ox) + (particle.y - oy) *
      (particle.y - oy)
  let dist = sqrt(distSquared)
  let sinForce = (particle.y - oy) / dist
  let cosForce = (particle.x - ox) / dist
  particle.vx += -10 * cosForce / distSquared
  particle.vy += -10 * sinForce / distSquared
  particle.x += particle.vx
  particle.y += particle.vy

var particles: seq[Particle]

proc setup() =
  particles = newSeq[Particle](5000)
  for i in 0..<particles.len:
    particles[i] = newParticle()
  background(255)

proc draw() =
  fill(255, 255, 255, 1)
  noStroke()
  rectFill(0, 0, width, height)
  stroke(0, 0, 0, 50)
  beginPixels()
  for _ in 0..<15: # 15 timesteps per frame
    for i in 0..<particles.len:
      particles[i].update()
      setPixel(particles[i].x, particles[i].y)

  endPixels()

run(800, 600, draw, setup)
