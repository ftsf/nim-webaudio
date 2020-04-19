import dom
import jsffi

type
  AudioContextObj {.importjs: "AudioContext".} = object of RootObj
    destination*: ref AudioDestinationNodeObj
    currentTime*: float
  AudioContext* = ref AudioContextObj
  AudioNodeObj {.importjs: "AudioNode".} = object of RootObj
    context*: AudioContext
    numberOfInputs*: int
    numberOfOutputs*: int
    channelCount*: int
    channelCountMode*: int
    channelInterpretation*: cstring
  AudioDestinationNodeObj {.importjs: "AudioDestinationNode".} = object of AudioNodeObj
  AudioParamObj {.importjs: "AudioParam".} = object of RootObj
    defaultValue*: float
    maxValue*: float
    minValue*: float
    value*: float
  AudioParam* = ref AudioParamObj
  AudioProcessingEventObj = object of Event
    inputBuffer*: AudioBuffer
    outputBuffer*: AudioBuffer
  AudioProcessingEvent* = ref AudioProcessingEventObj
  GainNodeObj {.importjs: "GainNode".} = object of AudioNodeObj
    gain*: AudioParam
  GainNode* = ref GainNodeObj
  OscillatorNodeObj {.importjs: "OscillatorNode".} = object of AudioNodeObj
    `type`*: cstring
    frequency*: AudioParam
    detune*: AudioParam
  ScriptProcessorNodeObj {.importjs: "ScriptProcessorNode", deprecated.} = object of AudioNodeObj
    bufferSize*: int
    onaudioprocess*: proc(e: AudioProcessingEvent)
  OscillatorNode* = ref OscillatorNodeObj
  ScriptProcessorNode* = ref ScriptProcessorNodeObj
  AudioNode* = ref AudioNodeObj
  AudioBuffer* {.importjs: "AudioBuffer".} = ref object of RootObj
    length*: int
  AudioBufferSourceNode* {.importjs: "AudioBufferSourceNode".} = ref object of AudioNodeObj
    buffer*: AudioBuffer
    detune*: AudioParamObj
    loop*: bool
    loopEnd*: AudioParamObj
    loopStart*: AudioParamObj
    playbackRate*: AudioParamObj
  PeriodicWaveObj = object of RootObj
  PeriodicWave* = ref PeriodicWaveObj
  MediaElementAudioSourceNodeObj = object of AudioNodeObj
  MediaElementAudioSourceNode* = ref MediaElementAudioSourceNodeObj

proc newAudioContext*(): AudioContext {.importjs: "new AudioContext()".}

proc createBuffer*(context: AudioContext, numOfChannels: int, length: int, sampleRate: int): AudioBuffer {.importjs: "#.createBuffer(@)"}
proc createBufferSource*(context: AudioContext): AudioBufferSourceNode {.importjs: "#.createBufferSource(@)".}
proc createGain*(context: AudioContext): GainNode {.importjs: "#.createGain(@)".}
proc createOscillator*(context: AudioContext): OscillatorNode {.importjs: "#.createOscillator(@)".}
proc createScriptProcessor*(context: AudioContext, bufferSize, inputChannels, outputChannels: int): ScriptProcessorNode {.importjs: "#.createScriptProcessor(@)", deprecated.}
proc createMediaElementSource*(context: AudioContext, el: Element): MediaElementAudioSourceNode {.importjs: "#.createMediaElementSource(@)".}

proc createPeriodicWave*(context: AudioContext, real, imag: openarray[float], options: JsAssoc = {}): PeriodicWave {.importjs:"#.createPeriodicWave(Float32Array.from(#), Float32Array.from(#))".}

proc getChannelData*(self: AudioBuffer, channel: int): seq[float32] {.importjs: "#.getChannelData(@)".}

proc start*(node: AudioNode) {.importjs:"#.start(@)".}
proc stop*(node: AudioNode) {.importjs:"#.stop(@)".}

proc start*(node: AudioNode, time: float) {.importjs:"#.start(@,@)".}
proc stop*(node: AudioNode, time: float) {.importjs:"#.stop(@,@)".}

proc setPeriodicWave*(osc: OscillatorNode, wave: PeriodicWave) {.importjs:"#.setPeriodicWave(@)".}

proc decodeAudioData*(ctx: AudioContext, audioData: cstring, success: proc(buffer: AudioBuffer), error: proc() = nil) {.importjs:"#.decodeAudioData(@)".}
proc resume*(ctx: AudioContext) {.importjs:"#.resume(@)".}

proc connect*(node: AudioNode, other: AudioNode): AudioNode {.importjs:"#.connect(@)", discardable.}
proc disconnect*(node: AudioNode, other: AudioNode) {.importjs:"#.disconnect(@)".}
proc disconnect*(node: AudioNode) {.importjs:"#.disconnect(@)".}
