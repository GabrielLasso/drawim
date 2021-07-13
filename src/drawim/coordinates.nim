import math

type
  Coordinates = object
    ox, oy: int
    rotation: float
    sin_rotation: float
    cos_rotation: float

var coordinates = Coordinates(cos_rotation: 1.0)
var coordinatesStack = newSeq[Coordinates]()

proc rotate*(theta: float) =
  coordinates.rotation += theta
  coordinates.sin_rotation = sin(coordinates.rotation)
  coordinates.cos_rotation = cos(coordinates.rotation)

proc translate*(x,y: int) =
  coordinates.ox += int(float(x)*coordinates.cos_rotation - float(y)*coordinates.sin_rotation)
  coordinates.oy += int(float(x)*coordinates.sin_rotation + float(y)*coordinates.cos_rotation)

proc push*() =
  coordinatesStack.add(coordinates)

proc pop*() =
  if coordinatesStack.len > 0:
    coordinates = coordinatesStack[^1]
    coordinatesStack.setLen(coordinatesStack.len - 1)

proc resetCoordinates*() =
    coordinates.rotation = 0.0
    coordinates.sin_rotation = 0.0
    coordinates.cos_rotation = 1.0
    coordinates.ox = 0
    coordinates.oy = 0

proc getRealPosition*(x,y: SomeNumber): (int, int) =
  let x_rot = int(float(coordinates.ox) + float(x)*coordinates.cos_rotation - float(y)*coordinates.sin_rotation)
  let y_rot = int(float(coordinates.oy) + float(x)*coordinates.sin_rotation + float(y)*coordinates.cos_rotation)
  result = (x_rot, y_rot)