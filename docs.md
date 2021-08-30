# Documentation

## Global variables
```nim
var height: int
var width: int
var frameCount: int
var deltaTime: float
```

## Colors
There are two color modes, `ColorMode.RGB` and `ColorMode.HSV`. You can set one or other using (`setColorMode()`).

In `RGB` mode, the values goes from `0` to `255` when a `int` is used, or from `0.0` to `1.0` when `float` is used.

In `HSV` mode, the hue value must be an integer from `0` to `359` degrees, and the saturation and value can be either an integer from `0` to `255` or a floating point from `0.0` to `1.0`.

Both modes also suport an alpha value from `0` to `255` or from `0.0` to `1.0`.

Drawing has two color slots, one to draw strokes and lines and other to fill polygons.

Procs:

```nim
proc stroke(rh, gs, bv: int | float) # Set the stroke color using the current color mode
proc stroke(rh, gs, bv, a: int | float) # Set the stroke color using the current color mode
proc stroke(gray: int | float) # Set the stroke color in gray scale
proc stroke(hex: string) # Set the stroke color using the hexadecimal string
proc noStroke() # Set the stroke color as transparent

proc fill(r, g, b: int | float) # Set the fill color using the current color mode
proc fill(r, g, b, a: int | float) # Set the fill color using the current color mode
proc fill(gray: int | float) # Set the fill color in gray scale
proc fill(hex: string) # Set the fill color using the hexadecimal string
proc noFill() # Set the fill color as transparent

proc background(rh, gs, bv: SomeNumber) # Fill the screen using the current color mode
proc background(gray: SomeNumber) # Fill the screen in gray scale

proc setColorMode(mode: ColorMode) # Set the color mode
```

## Shapes
Basic shapes:
```nim
proc rect(x, y, w, h: SomeNumber)
proc rectFill(x, y, w, h: SomeNumber)
proc triangle(x1, y1, x2, y2, x3, y3: SomeNumber)
proc triangleFill(x1, y1, x2, y2, x3, y3: SomeNumber)
proc arc(cx, cy, rx, ry: SomeNumber, beginAngle, endAngle: float, mode: ArcMode = Open)
proc arcFill(cx, cy, rx, ry: SomeNumber, beginAngle, endAngle: float, mode: ArcMode = Open)
proc ellipse(cx, cy, rx, ry: SomeNumber)
proc ellipseFill(cx, cy, rx, ry: SomeNumber)
proc circle(cx, cy, r: SomeNumber)
proc circleFill(cx, cy, r: SomeNumber)
proc line(x1, y1, x2, y2: SomeNumber)
```

To draw more complex shapes, call `vertex` between `beginShape` and `endShape` (the same for `beginPath` and `beginFilledShape`): 
```nim
proc beginPath()
proc beginShape()
proc beginFilledShape()
proc endPath()
proc endShape()
proc endFilledShape()
proc vertex(x, y: SomeNumber)
```

To set individual pixels to the stroke color, call `setPixel` between `beginPixels` and `endPixels`:
```nim
proc beginPixels()
proc endPixels()
proc setPixel(x, y: SomeNumber)
```

## Transform
These are the three basic transform operations:
```nim
proc rotate(theta: SomeNumber)
proc translate(x, y: SomeNumber)
proc scale(x, y: SomeNumber)
```

You can mix these operations, as well as save the transform state in a stack, to push and pop transforms:
```nim
proc push()
proc pop()
```

## Inputs
See the keys and mouse button codes [here](src/drawim/constants/keycodes.nim)

```nim
proc mouseX(): int
proc mouseY(): int
proc isKeyPressed(key: int): bool
proc isMousePressed(btn: int): bool
```