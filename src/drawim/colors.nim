import strutils
import math
when not defined(js):
  import backends/opengl_backend as backend
when defined(js):
  import backends/js_backend as backend

type
  ColorMode* = enum RGB, HSV
  Color = object
    case mode: ColorMode:
    of RGB:
      r, g, b: float
    of HSV:
      h: int
      s, v: float
    a: float

func newColorHSV(h: int, s, v, a: float): Color = Color(mode: HSV, h: h, s: s,
    v: v, a: a)
func newColorHSV(h, s, v, a: int): Color = Color(mode: HSV, h: h, s: s/100,
    v: v/100, a: a/255)

func newColorRGB(r, g, b, a: float): Color = Color(mode: RGB, r: r, g: g, b: b, a: a)
func newColorRGB(r, g, b, a: int): Color = Color(mode: RGB, r: r/255, g: g/255,
    b: b/255, a: a/255)

var fillColor: Color = newColorRGB(1.0, 1.0, 1.0, 1.0)
var strokeColor: Color = newColorRGB(0.0, 0.0, 0.0, 1.0)
var backgroundColor: Color = newColorRGB(0.0, 0.0, 0.0, 1.0)
var colorMode: ColorMode = RGB

proc setColorMode*(mode: ColorMode) =
  colorMode = mode

proc hsvToRgb(color: Color): Color =
  if color.mode != HSV:
    return color

  let c = color.s * color.v
  let x = c * (1 - abs((color.h / 60) mod 2.0 - 1))
  let m = color.v - c

  let (r, g, b) = case color.h mod 360:
  of 0..59:
    (c, x, 0.0)
  of 60..119:
    (x, c, 0.0)
  of 120..179:
    (0.0, c, x)
  of 180..239:
    (0.0, x, c)
  of 240..299:
    (x, 0.0, c)
  of 300..359:
    (c, 0.0, x)
  else:
    (0.0, 0.0, 0.0)

  result = newColorRGB(r+m, g+m, b+m, color.a)

proc fill*(r, g, b: float) =
  case colorMode:
  of (RGB):
    fillColor = newColorRGB(r, g, b, 1.0)
  of (HSV):
    raise newException(ValueError, "hue should be an integer")

proc fill*(rh, gs, bv: int) =
  case colorMode:
  of (RGB):
    fillColor = newColorRGB(rh, gs, bv, 255)
  of (HSV):
    fillColor = newColorHSV(rh, gs, bv, 255)

proc fill*(h: int, s, b: float) =
  case colorMode:
  of (RGB):
    raise newException(ValueError, "r, g, b should have the same type")
  of (HSV):
    fillColor = newColorHSV(h, s, b, 1.0)

proc fill*(r, g, b, a: float) =
  case colorMode:
  of (RGB):
    fillColor = newColorRGB(r, g, b, a)
  of (HSV):
    raise newException(ValueError, "hue should be an integer")

proc fill*(rh, gs, bv, a: int) =
  case colorMode:
  of (RGB):
    fillColor = newColorRGB(rh, gs, bv, a)
  of (HSV):
    fillColor = newColorHSV(rh, gs, bv, a)

proc fill*(h: int, s, b, a: float) =
  case colorMode:
  of (RGB):
    raise newException(ValueError, "r, g, b should have the same type")
  of (HSV):
    fillColor = newColorHSV(h, s, b, a)

proc fill*(gray: int|float) =
  case colorMode:
  of (RGB):
    fill(gray, gray, gray)
  of (HSV):
    discard # TODO

proc fill*(hex: string) =
  if colorMode == HSV:
    raise newException(ValueError, "Use RGB mode to use hex string")
  let sanitizedHex: string = hex.strip(chars = {'#'} + Whitespace)
  case sanitizedHex.len:
  of 3:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    fill(r, g, b)
  of 4:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    let a = sanitizedHex[3..<4].parseHexInt() * 16 + 15
    fill(r, g, b, a)
  of 6:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    fill(r, g, b)
  of 8:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    let a = sanitizedHex[6..<8].parseHexInt()
    fill(r, g, b, a)
  else:
    raise newException(ValueError, "Invalid　hex color")

proc stroke*(r, g, b: float) =
  case colorMode:
  of (RGB):
    strokeColor = newColorRGB(r, g, b, 1.0)
  of (HSV):
    raise newException(ValueError, "hue should be an integer")

proc stroke*(rh, gs, bv: int) =
  case colorMode:
  of (RGB):
    strokeColor = newColorRGB(rh, gs, bv, 255)
  of (HSV):
    strokeColor = newColorHSV(rh, gs, bv, 255)

proc stroke*(h: int, s, b: float) =
  case colorMode:
  of (RGB):
    raise newException(ValueError, "r, g, b should have the same type")
  of (HSV):
    strokeColor = newColorHSV(h, s, b, 1.0)

proc stroke*(r, g, b, a: float) =
  case colorMode:
  of (RGB):
    strokeColor = newColorRGB(r, g, b, a)
  of (HSV):
    raise newException(ValueError, "hue should be an integer")

proc stroke*(rh, gs, bv, a: int) =
  case colorMode:
  of (RGB):
    strokeColor = newColorRGB(rh, gs, bv, a)
  of (HSV):
    strokeColor = newColorHSV(rh, gs, bv, a)

proc stroke*(h: int, s, b, a: float) =
  case colorMode:
  of (RGB):
    raise newException(ValueError, "r, g, b should have the same type")
  of (HSV):
    strokeColor = newColorHSV(h, s, b, a)

proc stroke*(gray: int|float) =
  case colorMode:
  of (RGB):
    stroke(gray, gray, gray)
  of (HSV):
    discard # TODO

proc stroke*(hex: string) =
  if colorMode == HSV:
    raise newException(ValueError, "Use RGB mode to use hex string")
  let sanitizedHex: string = hex.strip(chars = {'#'} + Whitespace)
  case sanitizedHex.len:
  of 3:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    stroke(r, g, b)
  of 4:
    let r = sanitizedHex[0..<1].parseHexInt() * 16 + 15
    let g = sanitizedHex[1..<2].parseHexInt() * 16 + 15
    let b = sanitizedHex[2..<3].parseHexInt() * 16 + 15
    let a = sanitizedHex[3..<4].parseHexInt() * 16 + 15
    stroke(r, g, b, a)
  of 6:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    stroke(r, g, b)
  of 8:
    let r = sanitizedHex[0..<2].parseHexInt()
    let g = sanitizedHex[2..<4].parseHexInt()
    let b = sanitizedHex[4..<6].parseHexInt()
    let a = sanitizedHex[6..<8].parseHexInt()
    stroke(r, g, b, a)
  else:
    raise newException(ValueError, "Invalid　hex color")

proc setStrokeColor*() =
  case strokeColor.mode:
  of RGB:
    backend.changeColor(strokeColor.r, strokeColor.g, strokeColor.b, strokeColor.a)
  of HSV:
    let rgb = hsvToRgb(strokeColor)
    backend.changeColor(rgb.r, rgb.g, rgb.b, rgb.a)

proc setFillColor*() =
  case fillColor.mode:
  of RGB:
    backend.changeColor(fillColor.r, fillColor.g, fillColor.b, fillColor.a)
  of HSV:
    let rgb = hsvToRgb(fillColor)
    backend.changeColor(rgb.r, rgb.g, rgb.b, rgb.a)

proc setBackgroundColor() =
  case backgroundColor.mode:
  of RGB:
    backend.background(backgroundColor.r, backgroundColor.g, backgroundColor.b,
        backgroundColor.a)
  of HSV:
    let rgb = hsvToRgb(backgroundColor)
    backend.background(rgb.r, rgb.g, rgb.b, rgb.a)

proc background*(r, g, b: float) =
  case colorMode:
  of RGB:
    backgroundColor = newColorRGB(r, g, b, 1.0)
  of HSV:
    raise newException(ValueError, "hue should be an integer")
  setBackgroundColor()

proc background*(rh, gs, bv: int) =
  case colorMode:
  of RGB:
    backgroundColor = newColorRGB(rh, gs, bv, 255)
  of HSV:
    backgroundColor = newColorHSV(rh, gs, bv, 255)
  setBackgroundColor()

proc background*(h: int, s, v: float) =
  case colorMode:
  of RGB:
    raise newException(ValueError, "r, g, b should have the same type")
  of HSV:
    backgroundColor = newColorHSV(h, s, v, 255)
  setBackgroundColor()

proc background*(gray: float | int) =
  background(gray, gray, gray)
