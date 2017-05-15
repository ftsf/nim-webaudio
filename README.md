## Nim Wrapper for the Web Audio API

Example code for creating an oscillator that responds to clicks on the screen and fades and changes pitch over time.

```
import webaudio
import dom

var ctx = newAudioContext()

var gain = ctx.createGain()
gain.gain.value = 0.5
gain.connect(ctx.destination)

var osc = ctx.createOscillator()
osc.type = "square"
osc.frequency.value = 440.0
osc.connect(gain)
osc.start()

var interval = window.setInterval(
  proc() =
    if gain.gain.value > 0.0:
      gain.gain.value = gain.gain.value - 0.01
      if gain.gain.value < 0.0:
        gain.gain.value = 0.0
  , 30)

var interval2 = window.setInterval(
  proc() =
    osc.frequency.value *= 0.5
    if osc.frequency.value < 20.0:
      gain.gain.value = 0.0
  , 60)

window.addEventListener("mousedown") do(e: Event):
  osc.frequency.value = 880.0
  gain.gain.value = 0.5
```
