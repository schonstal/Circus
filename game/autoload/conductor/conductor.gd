extends Node

@export var bpm := 146.0

@onready var audio_stream_player := $AudioStreamPlayer

var note_types := {
  4: quarter,
  8: eighth,
  12: twelfth,
  16: sixteenth,
  24: twenty_fourth,
  32: thirty_second
}

var beats := {
  4: 0,
  8: 0,
  12: 0,
  16: 0,
  24: 0,
  32: 0
}

var time_begin := 0.0
var time_delay := 0.0

signal quarter(beat)
signal eighth(beat)
signal twelfth(beat)
signal sixteenth(beat)
signal twenty_fourth(beat)
signal thirty_second(beat)

func _ready() -> void:
  play_music()

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
  
  for type in note_types.keys():
    var bps:float = (type/4) * bpm / 60.0
    var current_beat = floor(bps * time)
    if current_beat > beats[type]:
      beats[type] = current_beat
      note_types[type].emit(int(beats[type]) % type)