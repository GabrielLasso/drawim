type 
  Key* = enum
    KEY_SPACE,
    KEY_APOSTROPHE,
    KEY_COMMA,
    KEY_MINUS,
    KEY_PERIOD,
    KEY_SLASH,
    KEY_0,
    KEY_1,
    KEY_2,
    KEY_3,
    KEY_4,
    KEY_5,
    KEY_6,
    KEY_7,
    KEY_8,
    KEY_9,
    KEY_SEMICOLON,
    KEY_EQUAL,
    KEY_A,
    KEY_B,
    KEY_C,
    KEY_D,
    KEY_E,
    KEY_F,
    KEY_G,
    KEY_H,
    KEY_I,
    KEY_J,
    KEY_K,
    KEY_L,
    KEY_M,
    KEY_N,
    KEY_O,
    KEY_P,
    KEY_Q,
    KEY_R,
    KEY_S,
    KEY_T,
    KEY_U,
    KEY_V,
    KEY_W,
    KEY_X,
    KEY_Y,
    KEY_Z,
    KEY_LEFT_BRACKET,
    KEY_BACKSLASH,
    KEY_RIGHT_BRACKET,
    KEY_GRAVE_ACCENT,
    KEY_WORLD_1,
    KEY_WORLD_2,
    KEY_ESCAPE,
    KEY_ENTER,
    KEY_TAB,
    KEY_BACKSPACE,
    KEY_INSERT,
    KEY_DELETE,
    KEY_RIGHT,
    KEY_LEFT,
    KEY_DOWN,
    KEY_UP,
    KEY_PAGE_UP,
    KEY_PAGE_DOWN,
    KEY_HOME,
    KEY_END,
    KEY_CAPS_LOCK,
    KEY_SCROLL_LOCK,
    KEY_NUM_LOCK,
    KEY_PRINT_SCREEN,
    KEY_PAUSE,
    KEY_F1,
    KEY_F2,
    KEY_F3,
    KEY_F4,
    KEY_F5,
    KEY_F6,
    KEY_F7,
    KEY_F8,
    KEY_F9,
    KEY_F10,
    KEY_F11,
    KEY_F12,
    KEY_F13,
    KEY_F14,
    KEY_F15,
    KEY_F16,
    KEY_F17,
    KEY_F18,
    KEY_F19,
    KEY_F20,
    KEY_F21,
    KEY_F22,
    KEY_F23,
    KEY_F24,
    KEY_F25,
    KEY_KP_0,
    KEY_KP_1,
    KEY_KP_2,
    KEY_KP_3,
    KEY_KP_4,
    KEY_KP_5,
    KEY_KP_6,
    KEY_KP_7,
    KEY_KP_8,
    KEY_KP_9,
    KEY_KP_DECIMAL,
    KEY_KP_DIVIDE,
    KEY_KP_MULTIPLY,
    KEY_KP_SUBTRACT,
    KEY_KP_ADD,
    KEY_KP_ENTER,
    KEY_KP_EQUAL,
    KEY_LEFT_SHIFT,
    KEY_LEFT_CONTROL,
    KEY_LEFT_ALT,
    KEY_LEFT_SUPER,
    KEY_RIGHT_SHIFT,
    KEY_RIGHT_CONTROL,
    KEY_RIGHT_ALT,
    KEY_RIGHT_SUPER,
    KEY_MENU,
    KEY_LAST

  MouseButton* = enum
    MOUSE_BUTTON_1,
    MOUSE_BUTTON_2,
    MOUSE_BUTTON_3,
    MOUSE_BUTTON_4,
    MOUSE_BUTTON_5,
    MOUSE_BUTTON_6,
    MOUSE_BUTTON_7,
    MOUSE_BUTTON_8,
    MOUSE_BUTTON_LAST,
    MOUSE_BUTTON_LEFT,
    MOUSE_BUTTON_RIGHT,
    MOUSE_BUTTON_MIDDLE

func getKeyCode*(key: Key): int =
  const isJs = defined(js)
  case key:
  of KEY_SPACE: result = 32
  of KEY_APOSTROPHE: result = if isJs: 222 else: 39
  of KEY_COMMA: result = if isJs: 188 else: 44
  of KEY_MINUS: result = if isJs: 173 else: 45
  of KEY_PERIOD: result = if isJs: 190 else: 46
  of KEY_SLASH: result = if isJs: 191 else: 47
  of KEY_0: result = 48
  of KEY_1: result = 49
  of KEY_2: result = 50
  of KEY_3: result = 51
  of KEY_4: result = 52
  of KEY_5: result = 53
  of KEY_6: result = 54
  of KEY_7: result = 55
  of KEY_8: result = 56
  of KEY_9: result = 57
  of KEY_SEMICOLON: result = 59
  of KEY_EQUAL: result = 61
  of KEY_A: result = 65
  of KEY_B: result = 66
  of KEY_C: result = 67
  of KEY_D: result = 68
  of KEY_E: result = 69
  of KEY_F: result = 70
  of KEY_G: result = 71
  of KEY_H: result = 72
  of KEY_I: result = 73
  of KEY_J: result = 74
  of KEY_K: result = 75
  of KEY_L: result = 76
  of KEY_M: result = 77
  of KEY_N: result = 78
  of KEY_O: result = 79
  of KEY_P: result = 80
  of KEY_Q: result = 81
  of KEY_R: result = 82
  of KEY_S: result = 83
  of KEY_T: result = 84
  of KEY_U: result = 85
  of KEY_V: result = 86
  of KEY_W: result = 87
  of KEY_X: result = 88
  of KEY_Y: result = 89
  of KEY_Z: result = 90
  of KEY_LEFT_BRACKET: result = if isJs: 219 else: 91
  of KEY_BACKSLASH: result = if isJs: 220 else: 92
  of KEY_RIGHT_BRACKET: result = if isJs: 221 else: 93
  of KEY_GRAVE_ACCENT: result = if isJs: 0 else: 96
  of KEY_WORLD_1: result = if isJs: 0 else: 161
  of KEY_WORLD_2: result = if isJs: 0 else: 162
  of KEY_ESCAPE: result = if isJs: 27 else: 256
  of KEY_ENTER: result = if isJs: 13 else: 257
  of KEY_TAB: result = if isJs: 9 else: 258
  of KEY_BACKSPACE: result = if isJs: 8 else: 259
  of KEY_INSERT: result = if isJs: 45 else: 260
  of KEY_DELETE: result = if isJs: 46 else: 261
  of KEY_RIGHT: result = if isJs: 39 else: 262
  of KEY_LEFT: result = if isJs: 37 else: 263
  of KEY_DOWN: result = if isJs: 40 else: 264
  of KEY_UP: result = if isJs: 38 else: 265
  of KEY_PAGE_UP: result = if isJs: 33 else: 266
  of KEY_PAGE_DOWN: result = if isJs: 34 else: 267
  of KEY_HOME: result = if isJs: 36 else: 268
  of KEY_END: result = if isJs: 35 else: 269
  of KEY_CAPS_LOCK: result = if isJs: 20 else: 280
  of KEY_SCROLL_LOCK: result = if isJs: 145 else: 281
  of KEY_NUM_LOCK: result = if isJs: 144 else: 282
  of KEY_PRINT_SCREEN: result = if isJs: 44 else: 283
  of KEY_PAUSE: result = if isJs: 19 else: 284
  of KEY_F1: result = if isJs: 112 else: 290
  of KEY_F2: result = if isJs: 113 else: 291
  of KEY_F3: result = if isJs: 114 else: 292
  of KEY_F4: result = if isJs: 115 else: 293
  of KEY_F5: result = if isJs: 116 else: 294
  of KEY_F6: result = if isJs: 117 else: 295
  of KEY_F7: result = if isJs: 118 else: 296
  of KEY_F8: result = if isJs: 119 else: 297
  of KEY_F9: result = if isJs: 120 else: 298
  of KEY_F10: result = if isJs: 121 else: 299
  of KEY_F11: result = if isJs: 122 else: 300
  of KEY_F12: result = if isJs: 123 else: 301
  of KEY_F13: result = if isJs: 124 else: 302
  of KEY_F14: result = if isJs: 125 else: 303
  of KEY_F15: result = if isJs: 126 else: 304
  of KEY_F16: result = if isJs: 127 else: 305
  of KEY_F17: result = if isJs: 128 else: 306
  of KEY_F18: result = if isJs: 129 else: 307
  of KEY_F19: result = if isJs: 130 else: 308
  of KEY_F20: result = if isJs: 131 else: 309
  of KEY_F21: result = if isJs: 132 else: 310
  of KEY_F22: result = if isJs: 133 else: 311
  of KEY_F23: result = if isJs: 134 else: 312
  of KEY_F24: result = if isJs: 135 else: 313
  of KEY_F25: result = if isJs: 136 else: 314
  of KEY_KP_0: result = if isJs: 96 else: 320
  of KEY_KP_1: result = if isJs: 97 else: 321
  of KEY_KP_2: result = if isJs: 98 else: 322
  of KEY_KP_3: result = if isJs: 99 else: 323
  of KEY_KP_4: result = if isJs: 100 else: 324
  of KEY_KP_5: result = if isJs: 101 else: 325
  of KEY_KP_6: result = if isJs: 102 else: 326
  of KEY_KP_7: result = if isJs: 103 else: 327
  of KEY_KP_8: result = if isJs: 104 else: 28
  of KEY_KP_9: result = if isJs: 105 else: 329
  of KEY_KP_DECIMAL: result = if isJs: 110 else: 330
  of KEY_KP_DIVIDE: result = if isJs: 111 else: 331
  of KEY_KP_MULTIPLY: result = if isJs: 106 else: 332
  of KEY_KP_SUBTRACT: result = if isJs: 109 else: 333
  of KEY_KP_ADD: result = if isJs: 107 else: 334
  of KEY_KP_ENTER: result = if isJs: 13 else: 335
  of KEY_KP_EQUAL: result = if isJs: 0 else: 336
  of KEY_LEFT_SHIFT: result = if isJs: 19 else: 340
  of KEY_LEFT_CONTROL: result = if isJs: 17 else: 341
  of KEY_LEFT_ALT: result = if isJs: 18 else: 342
  of KEY_LEFT_SUPER: result = if isJs: 91 else: 343
  of KEY_RIGHT_SHIFT: result = if isJs: 19 else: 344
  of KEY_RIGHT_CONTROL: result = if isJs: 17 else: 345
  of KEY_RIGHT_ALT: result = if isJs: 18 else: 346
  of KEY_RIGHT_SUPER: result = if isJs: 91 else: 347
  of KEY_MENU: result = if isJs: 0 else: 348
  of KEY_LAST: result = if isJs: 0 else: 348

func getMouseButtonCode*(btn: MouseButton): int =
  case btn:
  of MOUSE_BUTTON_1: result = 0
  of MOUSE_BUTTON_2: result = 1
  of MOUSE_BUTTON_3: result = 2
  of MOUSE_BUTTON_4: result = 3
  of MOUSE_BUTTON_5: result = 4
  of MOUSE_BUTTON_6: result = 5
  of MOUSE_BUTTON_7: result = 6
  of MOUSE_BUTTON_8: result = 7
  of MOUSE_BUTTON_LAST: result = getMouseButtonCode(MOUSE_BUTTON_8)
  of MOUSE_BUTTON_LEFT: result = getMouseButtonCode(MOUSE_BUTTON_1)
  of MOUSE_BUTTON_RIGHT: result = getMouseButtonCode(MOUSE_BUTTON_2)
  of MOUSE_BUTTON_MIDDLE: result = getMouseButtonCode(MOUSE_BUTTON_3)
