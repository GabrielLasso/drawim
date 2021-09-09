import config, drawim, food, snake

var player: Snake = initSnake(5, 5)
var nextFood: Food = initFood()

proc handleInput() =
  if isKeyPressed(KEY_UP) and player.direction != (0, 1):
    player.direction = (0, -1)
  elif isKeyPressed(KEY_LEFT) and player.direction != (1, 0):
    player.direction = (-1, 0)
  elif isKeyPressed(KEY_RIGHT) and player.direction != (-1, 0):
    player.direction = (1, 0)
  elif isKeyPressed(KEY_DOWN) and player.direction != (0, -1):
    player.direction = (0, 1)

proc setup() =
  setFrameRate(5)

proc draw() =
  background(50)
  handleInput()
  if (player.position == nextFood.position):
    player.grow()
    nextFood = initFood()
  nextFood.draw()
  player.update()
  player.draw()
  if player.dead():
    quit()


run(TILE_SIZE * WIDTH, TILE_SIZE * HEIGHT, draw, setup, name = "Snake")
