import std/math

type
  Transformation = ((float, float, float), (float, float, float))
  Vector2D = (float, float)

var matrix = (
  (1.0, 0.0, 0.0),
  (0.0, 1.0, 0.0),
)
var reverse_matrix = (
  (1.0, 0.0, 0.0),
  (0.0, 1.0, 0.0),
)
var transformationStack = newSeq[Transformation]()

func `*`(x: Vector2D, A: Transformation): Vector2D =
  result = (
    x[0]*A[0][0] + x[1]*A[0][1] + A[0][2],
    x[0]*A[1][0] + x[1]*A[1][1] + A[1][2]
  )

func `*`(A: Transformation, B: Transformation): Transformation =
  result = (
    (A[0][0]*B[0][0] + A[0][1]*B[1][0], A[0][0]*B[0][1] + A[0][1]*B[1][1], A[0][
        0]*B[0][2] + A[0][1]*B[1][2] + A[0][2]),
    (A[1][0]*B[0][0] + A[1][1]*B[1][0], A[1][0]*B[0][1] + A[1][1]*B[1][1], A[1][
        0]*B[0][2] + A[1][1]*B[1][2] + A[1][2])
  )

proc rotate*(theta: int|float) =
  let rotation = (
    (cos(theta), sin(theta), 0.0),
    (-sin(theta), cos(theta), 0.0)
  )
  let reverse_rotation = (
    (cos(-theta), sin(-theta), 0.0),
    (-sin(-theta), cos(-theta), 0.0)
  )
  matrix = matrix * rotation
  reverse_matrix = reverse_matrix * reverse_rotation

proc translate*(x, y: int|float) =
  let tranlation = (
    (1.0, 0.0, float(x)),
    (0.0, 1.0, float(y))
  )
  let reverse_translation = (
    (1.0, 0.0, float(-x)),
    (0.0, 1.0, float(-y))
  )
  matrix = matrix * tranlation
  reverse_matrix = reverse_matrix * reverse_translation

proc scale*(x, y: int|float) =
  let scale = (
    (float(x), 0.0, 0.0),
    (0.0, float(y), 0.0)
  )
  let reverse_scale = (
    (1 / float(x), 0.0, 0.0),
    (0.0, 1 / float(y), 0.0)
  )
  matrix = matrix * scale
  reverse_matrix = reverse_matrix * reverse_scale

proc push*() =
  transformationStack.add(matrix)

proc pop*() =
  if transformationStack.len > 0:
    matrix = transformationStack[^1]
    transformationStack.setLen(transformationStack.len - 1)

proc resetTransform*() =
  matrix = (
    (1.0, 0.0, 0.0),
    (0.0, 1.0, 0.0)
  )
  reverse_matrix = (
    (1.0, 0.0, 0.0),
    (0.0, 1.0, 0.0)
  )

proc getScreenPosition*(x, y: int|float): (int, int) =
  let (x_res, y_res) = (float(x), float(y)) * matrix
  result = (int(x_res), int(y_res))

proc getRealPosition*(x, y: int): (int, int) =
  let (x_res, y_res) = (float(x), float(y)) * reverse_matrix
  result = (int(x_res), int(y_res))
