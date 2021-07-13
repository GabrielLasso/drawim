import strutils
when not defined(js):
  import backends/opengl_backend as backend

var fillColor: (float, float, float, float) = (1.0, 1.0, 1.0, 1.0)
var strokeColor: (float, float, float, float) = (0.0, 0.0, 0.0, 1.0)

proc rgbIntToFloat*(r,g,b: int): (float, float, float) =
  return (r/255, g/255, b/255)

proc rgbIntToFloat*(r,g,b,a: int): (float, float, float, float) =
  return (r/255, g/255, b/255, a/255)

proc fill*(r, g, b: float) =
  fillColor = (r, g, b, 1.0)

proc fill*(r, g, b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  fillColor = (r_f, g_f, b_f, 1.0)

proc fill*(r, g, b, a: float) =
  fillColor = (r, g, b, a)

proc fill*(r, g, b, a: int) =
  let (r_f, g_f, b_f, a_f) = rgbIntToFloat(r,g,b,a)
  fillColor = (r_f, g_f, b_f, a_f)

proc fill*(gray: int | float) =
  fill(gray, gray, gray)

proc fill*(hex: string) =
  let sanitizedHex: string = hex.strip(chars = {'#'} + Whitespace)
  case sanitizedHex.len:
  of 3:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    fill(r,g,b)
  of 4:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    let a = sanitizedHex[3..<4].parseHexInt() * 16 + 15
    fill(r,g,b,a)
  of 6:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    fill(r,g,b)
  of 8:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    let a = sanitizedHex[6..<8].parseHexInt()
    fill(r,g,b,a)
  else:
    raise newException(ValueError, "Invalid　hex color")

proc stroke*(r, g, b: float) =
  strokeColor = (r, g, b, 1.0)

proc stroke*(r, g, b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  strokeColor = (r_f, g_f, b_f, 1.0)

proc stroke*(r, g, b, a: float) =
  strokeColor = (r, g, b, a)

proc stroke*(r, g, b, a: int) =
  let (r_f, g_f, b_f, a_f) = rgbIntToFloat(r,g,b,a)
  strokeColor = (r_f, g_f, b_f, a_f)

proc stroke*(gray: int | float) =
  stroke(gray, gray, gray)

proc stroke*(hex: string) =
  let sanitizedHex: string = hex.strip(chars = {'#'} + Whitespace)
  case sanitizedHex.len:
  of 3:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    stroke(r,g,b)
  of 4:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    let a = sanitizedHex[3..<4].parseHexInt() * 16 + 15
    stroke(r,g,b,a)
  of 6:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    stroke(r,g,b)
  of 8:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    let a = sanitizedHex[6..<8].parseHexInt()
    stroke(r,g,b,a)
  else:
    raise newException(ValueError, "Invalid　hex color")

proc setStrokeColor*() =
  backend.changeColor(strokeColor[0], strokeColor[1], strokeColor[2], strokeColor[3])

proc setFillColor*() =
  backend.changeColor(fillColor[0], fillColor[1], fillColor[2], fillColor[3])

proc background*(r,g,b: int) =
  let (r_f, g_f, b_f) = rgbIntToFloat(r,g,b)
  backend.background(r_f,g_f,b_f)

proc background*(r,g,b: float) =
  backend.background(r,g,b)

proc background*(gray: float | int) =
  background(gray, gray, gray)