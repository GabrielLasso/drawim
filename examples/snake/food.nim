import random
import drawim

import config

type Food* = object
  position*: (int, int)

proc initFood*(): Food =
  result.position = (rand(0..<WIDTH), rand(0..<HEIGHT))

proc draw*(food: Food) =
  fill(255,0,0)
  rectFill(food.position[0] * TILE_SIZE, food.position[1] * TILE_SIZE, TILE_SIZE, TILE_SIZE)