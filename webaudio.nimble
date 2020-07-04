# Package

version       = "0.2.1"
author        = "Jez Kabanov"
description   = "API for Web Audio (JS)"
license       = "MIT"

# Dependencies

requires "nim >= 1.0.0"

skipDirs = @["tests"]

task test, "run tests":
  exec("nim js -o:tests/test.js --path:. tests/test.nim")
