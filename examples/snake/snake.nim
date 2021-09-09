import drawim
import deques

import config

type
  Snake* = object
    position*: (int, int)
    direction*: (int, int)
    tail: Deque[(int, int)]

proc grow*(snake: var Snake) =
  snake.tail.addFirst(snake.position)

proc initSnake*(x, y: int): Snake =
  result.position = (x, y)
  result.direction = (1, 0)
  result.tail = initDeque[(int, int)]()
  result.grow()

proc update*(snake: var Snake) =
  snake.tail.addFirst(snake.position)
  discard snake.tail.popLast()
  snake.position[0] += snake.direction[0]
  snake.position[1] += snake.direction[1]

proc draw*(snake: Snake) =
  fill(0,255,0)
  rectFill(snake.position[0] * TILE_SIZE, snake.position[1] * TILE_SIZE, TILE_SIZE, TILE_SIZE)
  for t in snake.tail:
    rectFill(t[0] * TILE_SIZE, t[1] * TILE_SIZE, TILE_SIZE, TILE_SIZE)

proc dead*(snake: Snake): bool =
  if snake.position[0] < 0 or snake.position[0] >= WIDTH or snake.position[1] < 0 or snake.position[1] >= HEIGHT:
    return true
  for position in snake.tail:
    if snake.position == position:
      return true
  