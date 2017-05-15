# Package

version       = "0.1.0"
author        = "Jez Kabanov"
description   = "API for Web Audio (JS)"
license       = "MIT"

# Dependencies

requires "nim >= 0.16.1"

skipDirs = @["tests"]

task test, "run tests":
  exec("nim js -o:tests/test.js --path:. tests/test.nim")
