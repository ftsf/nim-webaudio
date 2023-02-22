## Nim Wrapper for the Web Audio API

Example code for creating an oscillator that responds to clicks on the screen and fades and changes pitch over time.

[Try it!](https://cdn.rawgit.com/ftsf/nim-webaudio/4588fab0/tests/test.html)

```nim
import webaudio
import dom

var ctx = newAudioContext()

var gain = ctx.createGain()
gain.gain.setValueAtTime(0.0, ctx.currentTime)
gain.connect(ctx.destination)

var osc = ctx.createOscillator()
osc.type = "square"
osc.frequency.setValueAtTime(440, ctx.currentTime)
osc.connect(gain)
osc.start()

window.addEventListener("mousedown") do(e: Event):
  osc.frequency.linearRampToValueAtTime(880, ctx.currentTime + 2)
  gain.gain.linearRampToValueAtTime(0.5, ctx.currentTime + 2)
```
