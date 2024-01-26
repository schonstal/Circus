extends Node

@export var bpm := 146.0

@onready var audio_stream_player := $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var beat := 0
var time_begin := 0.0
var time_delay := 0.0

signal quarter(beat)
signal thirty_second
signal sixteenth
signal eighth
signal twelfth
signal twenty_forth

func play_music() -> void:
  time_begin = Time.get_ticks_usec()
  time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
  audio_stream_player.play()

func _process(_delta: float) -> void:
  if !audio_stream_player.playing:
    return

  var time = (Time.get_ticks_usec() - time_begin) / 1_000_000.0
  time -= time_delay
  if time < 0:
    time = 0
    return
  
  var bps:float = bpm / 60.0
  var current_beat:int = floor(bps * time)
  
  if current_beat > beat:
    beat = current_beat
    quarter.emit(beat)
