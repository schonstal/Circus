extends Node

@export var bpm := 146.0

@onready var audio_stream_player := $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var beat := 0
var time_begin := 0.0
var time_delay := 0.0

func _ready() -> void:
  await get_tree().create_timer(3.).timeout
  time_begin = Time.get_ticks_usec()
  time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
  audio_stream_player.play()
  await get_tree().create_timer(time_delay)
  animation_player.play("chart")

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
    EventBus.measure_changed.emit(beat % 4 + 1)
