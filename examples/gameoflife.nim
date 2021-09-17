import drawim, std/sequtils, std/random

type
  Cell = ref object
    alive: bool
  Grid = ref object
    tiles: seq[seq[Cell]]

const gridHeight = 200
const gridWidth = 200

var grid: Grid

proc initGrid(w,h: int): Grid =
  result = new Grid
  result.tiles = newSeq[seq[Cell]]()
  for x in 0..<gridHeight:
    result.tiles.add newSeq[Cell]()
    for y in 0..<gridHeight:
      result.tiles[x].add Cell()
      result.tiles[x][y].alive = rand(100) < 10

func copyGrid(b: Grid): Grid =
  result = new Grid
  result.tiles = newSeq[seq[Cell]]()
  for x in 0..<b.tiles.len:
    result.tiles.add newSeq[Cell]()
    for y in 0..<b.tiles[0].len:
      result.tiles[x].add Cell()
      result.tiles[x][y].alive = b.tiles[x][y].alive

func neighbours(grid: Grid, x, y: int): seq[Cell] =
  for newx in x-1..x+1:
    for newy in y-1..y+1:
      if newx < 0 or newy < 0: continue
      if newx >= grid.tiles.len or newy >= grid.tiles[newx].len: continue
      if newx == x and newy == y: continue
      result.add grid.tiles[newx][newy]

proc draw(grid: Grid) =
  for x in 0..<gridWidth:
    for y in 0..<gridHeight:
      if grid.tiles[x][y].alive:
        rectfill((x * width) / gridWidth, (y * height) / gridHeight, width / gridWidth, height / gridHeight)

proc update(grid: Grid) =
  var tempBoard = copyGrid(grid)
  for x in 0..<gridWidth:
    for y in 0..<gridHeight:
      let aliveNeighbours = tempBoard.neighbours(x, y).filterIt(it.alive == true)
      if aliveNeighbours.len >= 4:
        grid.tiles[x][y].alive = false
      if aliveNeighbours.len <= 1:
        grid.tiles[x][y].alive = false
      if aliveNeighbours.len == 3:
        grid.tiles[x][y].alive = true

proc setup() =
  grid = initGrid(gridWidth, gridHeight)

proc draw() =
  background(255)
  grid.update()
  grid.draw()

run(600, 600, draw, setup)
