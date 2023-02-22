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

discard window.setInterval(
  proc() =
    if gain.gain.value > 0.0:
      gain.gain.value -= 0.01
      if gain.gain.value < 0.0:
        gain.gain.value = 0.0
  , 30)

discard window.setInterval(
  proc() =
    osc.frequency.value *= 0.5
    if osc.frequency.value < 20.0:
      gain.gain.value = 0.0
  , 60)

window.addEventListener("mousedown") do(e: Event):
  osc.stop()
  osc = ctx.createOscillator()
  osc.type = "square"
  osc.frequency.value = 880.0
  osc.connect(gain)
  gain.gain.value = 0.5
  osc.start()
