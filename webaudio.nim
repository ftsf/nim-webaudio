import dom
import jsffi

type
  AudioContextObj {.importc.} = object of RootObj
    destination*: ref AudioDestinationNodeObj
    currentTime*: float
  AudioContext* = ref AudioContextObj
  AudioNodeObj {.importc.} = object of RootObj
    context*: AudioContext
    numberOfInputs*: int
    numberOfOutputs*: int
    channelCount*: int
    channelCountMode*: int
    channelInterpretation*: cstring
  AudioDestinationNodeObj {.importc.} = object of AudioNodeObj
  AudioParamObj {.importc.} = object of RootObj
    defaultValue*: float
    maxValue*: float
    minValue*: float
    value*: float
  AudioParam* = ref AudioParamObj
  AudioProcessingEventObj = object of Event
    inputBuffer*: AudioBuffer
    outputBuffer*: AudioBuffer
  AudioProcessingEvent* = ref AudioProcessingEventObj
  GainNodeObj {.importc.} = object of AudioNodeObj
    gain*: AudioParam
  GainNode* = ref GainNodeObj
  OscillatorNodeObj {.importc.} = object of AudioNodeObj
    `type`*: cstring
    frequency*: AudioParam
    detune*: AudioParam
  ScriptProcessorNodeObj {.importcpp.} = object of AudioNodeObj
    bufferSize*: int
    onaudioprocess*: proc(e: AudioProcessingEvent)
  OscillatorNode* = ref OscillatorNodeObj
  ScriptProcessorNode* = ref ScriptProcessorNodeObj
  AudioNode* = ref AudioNodeObj
  AudioBuffer* {.importc.} = ref object of RootObj
    length*: int
  AudioBufferSourceNode* {.importc.} = ref object of AudioNodeObj
    buffer*: AudioBuffer
    detune*: float
    loop*: bool
    loopEnd*: float
    loopStart*: float
    playbackRate*: float
  PeriodicWaveObj = object of RootObj
  PeriodicWave* = ref PeriodicWaveObj
  MediaElementAudioSourceNodeObj = object of AudioNodeObj
  MediaElementAudioSourceNode* = ref MediaElementAudioSourceNodeObj

proc newAudioContext*(): AudioContext {.importcpp: "new AudioContext()".}

proc createBufferSource*(context: AudioContext): AudioBufferSourceNode {.importcpp: "#.createBufferSource(@)".}
proc createGain*(context: AudioContext): GainNode {.importcpp: "#.createGain(@)".}
proc createOscillator*(context: AudioContext): OscillatorNode {.importcpp: "#.createOscillator(@)".}
proc createScriptProcessor*(context: AudioContext, bufferSize, inputChannels, outputChannels: int): ScriptProcessorNode {.importcpp: "#.createScriptProcessor(@)".}
proc createMediaElementSource*(context: AudioContext, el: HtmlElement): MediaElementAudioSourceNode {.importcpp.}

proc createPeriodicWave*(context: AudioContext, real, imag: openarray[float], options: JsAssoc = {}): PeriodicWave {.importcpp:"#.createPeriodicWave(Float32Array.from(#), Float32Array.from(#))".}

proc getChannelData*(self: AudioBuffer, channel: int): seq[float32] {.importcpp.}

proc start*(node: AudioNode) {.importcpp:"#.start(@)".}
proc stop*(node: AudioNode) {.importcpp:"#.stop(@)".}

proc start*(node: AudioNode, time: float) {.importcpp:"#.start(@,@)".}
proc stop*(node: AudioNode, time: float) {.importcpp:"#.start(@,@)".}

proc setPeriodicWave*(osc: OscillatorNode, wave: PeriodicWave) {.importcpp:"#.setPeriodicWave(@)".}

proc decodeAudioData*(ctx: AudioContext, audioData: cstring, success: proc(buffer: AudioBuffer), error: proc() = nil) {.importcpp:"#.decodeAudioData(@)".}
proc resume*(ctx: AudioContext) {.importcpp:"#.resume(@)".}

proc connect*(node: AudioNode, other: AudioNode): AudioNode {.importcpp:"#.connect(@)", discardable.}
proc disconnect*(node: AudioNode, other: AudioNode) {.importcpp:"#.disconnect(@)".}
