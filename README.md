# Drawim
A simple drawing library in Nim, inspired by p5js. Builds to native, using OpenGL, and to JavaScript, using HTML5 Canvas.

## Usage
A simple example, to draw a rectangle:
```nim
import drawim

proc draw() =
  background(0)
  fill(255, 0, 0)
  translate(int(width / 2), int(height / 2))
  rectFill(-100,-100,100,100)

run(600, 400, draw, name = "Drawim example")
```

To run the example, you can either `nim r example.nim` or `nim js example.nim` and include the resulting js in an HTML file containing a div with `id="Drawim example"`.

More examples can be found on `examples/` folder.

## Installation
Just install with numble by running

```
nimble install drawim
```

## Features
- Compiles to native and JS
- 100% Nim code
- Basic drawing
- Read keyboard and mouse input
- Limit the framerate
- Rotate, translate and scale
- Save transform state in a stack (see examples/tree.nim)
- RGB and HSV colors
- Bezier curves
- Easy to extend and create new curves

To do:
- Stroke weight
- Load sprites
- Spritemaps

## Documentation
You can find the full docs [here](docs.md)