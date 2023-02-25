import dom
import jsffi
import std/asyncjs

type
  AudioNodeObj {.importjs: "AudioNode".} = object of RootObj
    context*: AudioContext
    numberOfInputs*: int
    numberOfOutputs*: int
    channelCount*: int
    channelCountMode*: int
    channelInterpretation*: cstring
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

  AudioContextObj {.importjs: "AudioContext".} = object of RootObj
    audioWorklet*: AudioWorklet
    currentTime*: float
    destination*: ref AudioDestinationNodeObj
    listener*: AudioListener
    sampleRate*: float
    state*: cstring
  AudioContext* = ref AudioContextObj

  AudioDestinationNodeObj {.importjs: "AudioDestinationNode".} = object of AudioNodeObj

  AudioListenerObj {.importjs: "AudioListener".} = object of RootObj
    forwardX*: AudioParam
    forwardY*: AudioParam 
    forwardZ*: AudioParam
    positionX*: AudioParam
    positionY*: AudioParam
    positionZ*: AudioParam
    upX*: AudioParam
    upY*: AudioParam
    upZ*: AudioParam
  AudioListener* = ref AudioListenerObj

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

  AudioWorkletGlobalScopeObj {.importjs: "AudioWorkletGlobalScope".} = object of RootObj
  AudioWorkletGlobalScope* = ref AudioWorkletGlobalScopeObj
  AudioWorkletObj {.importjs: "AudioWorklet".} = object of RootObj
  AudioWorklet* = ref AudioWorkletObj
  AudioWorkletNodeObj  {.importjs: "AudioWorkletNode".} = object of AudioNodeObj
  AudioWorkletNode* = ref AudioWorkletNodeObj
  AudioWorkletProcessorObj {.importjs: "AudioWorkletProcessor".} = object of RootObj
  AudioWorkletProcessor* = ref AudioWorkletProcessorObj

  GainNodeObj {.importjs: "GainNode".} = object of AudioNodeObj
    gain*: AudioParam
  GainNode* = ref GainNodeObj

  MediaElementAudioSourceNodeObj = object of AudioNodeObj
  MediaElementAudioSourceNode* = ref MediaElementAudioSourceNodeObj

  OscillatorNodeObj {.importjs: "OscillatorNode".} = object of AudioNodeObj
    `type`*: cstring
    frequency*: AudioParam
    detune*: AudioParam
  OscillatorNode* = ref OscillatorNodeObj

  PeriodicWaveObj = object of RootObj
  PeriodicWave* = ref PeriodicWaveObj

  ScriptProcessorNodeObj {.importjs: "ScriptProcessorNode", deprecated.} = object of AudioNodeObj
    bufferSize*: int
    onaudioprocess*: proc(e: AudioProcessingEvent)
  ScriptProcessorNode* = ref ScriptProcessorNodeObj

{.emit:"""
var AudioContext = window.AudioContext || window.webkitAudioContext || null;
""".}

proc getChannelData*(self: AudioBuffer, channel: int): seq[float32] {.importjs: "#.getChannelData(@)".}

proc createBuffer*(context: AudioContext, numOfChannels: int, length: int, sampleRate: int): AudioBuffer {.importjs: "#.createBuffer(@)"}
proc createBufferSource*(context: AudioContext): AudioBufferSourceNode {.importjs: "#.createBufferSource(@)".}
proc createGain*(context: AudioContext): GainNode {.importjs: "#.createGain(@)".}
proc createMediaElementSource*(context: AudioContext, el: Element): MediaElementAudioSourceNode {.importjs: "#.createMediaElementSource(@)".}
proc createOscillator*(context: AudioContext): OscillatorNode {.importjs: "#.createOscillator(@)".}
proc createPeriodicWave*(context: AudioContext, real, imag: openarray[float], options: JsAssoc = {}): PeriodicWave {.importjs: "#.createPeriodicWave(Float32Array.from(#), Float32Array.from(#))".}
proc createScriptProcessor*(context: AudioContext, bufferSize, inputChannels, outputChannels: int): ScriptProcessorNode {.importjs: "#.createScriptProcessor(@)", deprecated.}
proc decodeAudioData*(ctx: AudioContext, audioData: cstring, success: proc(buffer: AudioBuffer), error: proc() = nil) {.importjs: "#.decodeAudioData(@)".}
proc newAudioContext*(): AudioContext {.importjs: "new AudioContext()".}
proc newAudioWorkletNode*(ctx: AudioContext, name: cstring): AudioNode {.importjs: "new AudioWorkletNode(@,@)".}
proc suspend*(ctx: AudioContext) {.importjs: "#.suspend(@)".}
proc resume*(ctx: AudioContext) {.importjs: "#.resume(@)".}

proc connect*(node: AudioNode, other: AudioNode): AudioNode {.importjs: "#.connect(@)", discardable.}
proc connect*(node: AudioNode, other: AudioParam) {.importjs: "#.connect(@)", discardable.}
proc disconnect*(node: AudioNode, other: AudioNode) {.importjs: "#.disconnect(@)".}
proc disconnect*(node: AudioNode) {.importjs: "#.disconnect(@)".}
proc start*(node: AudioNode) {.importjs: "#.start(@)".}
proc start*(node: AudioNode, time: float) {.importjs: "#.start(@,@)".}
proc stop*(node: AudioNode) {.importjs: "#.stop(@)".}
proc stop*(node: AudioNode, time: float) {.importjs: "#.stop(@,@)".}

proc cancelAndHoldAtTime*(param: AudioParam, cancelTime: float) {.importjs: "#.cancelAndHoldAtTime(@,@)".}
proc cancelScheduledValues*(param: AudioParam, startTime: float) {.importjs: "#.cancelScheduledValues(@,@)".}
proc exponentialRampToValueAtTime*(param: AudioParam, value: float, endTime: float) {.importjs: "#.exponentialRampToValueAtTime(@,@,@)".}
proc linearRampToValueAtTime*(param: AudioParam, value: float, endTime: float) {.importjs: "#.linearRampToValueAtTime(@,@,@)".}
proc setTargetAtTime*(param: AudioParam, value: float, startTime: float, timeConstant: float) {.importjs: "#.setTargetAtTime*((@,@,@)".}
proc setValueAtTime*(param: AudioParam, value: float, startTime: float) {.importjs: "#.setValueAtTime(@,@,@)".}
proc setValueCurveAtTime*(param: AudioParam, values:openArray[float], startTime: float, duration: float) {.importjs: "#.setValueCurveAtTime(@,@,@,@)".}

proc setPeriodicWave*(osc: OscillatorNode, wave: PeriodicWave) {.importjs: "#.setPeriodicWave(@)".}

proc registerProcessor*(scope: AudioWorkletGlobalScope, name: cstring, processorCtor: proc() : AudioWorkletProcessor) {.importjs: "#.registerProcessor(Float32Array.from(#), Float32Array.from(#))".}
proc addModule*(worklet: AudioWorklet, moduleURL: cstring) : Future[jsNull]  {.importjs: "#.$1(#)", discardable.}
