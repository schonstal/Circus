extends Node

@export var bpm := 146.0

@onready var audio_stream_player := $AudioStreamPlayer

var beat := 0
var time := 0.0

func _ready() -> void:
  var sync := AudioServer.get_time_to_next_mix()
  await get_tree().create_timer(sync)
  audio_stream_player.play()

func _process(_delta: float) -> void:
  var sync: float = AudioServer.get_time_to_next_mix() - AudioServer.get_output_latency()
  var time: float = audio_stream_player.get_playback_position() + sync
  
  var bps := (bpm * 0.25 / 60.0)
  var current_beat := int(time / bps)
  
  if current_beat > beat:
    beat = current_beat
    EventBus.measure_changed.emit(beat % 4 + 1)
