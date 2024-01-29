extends Node

@export var bpm := 146.0

@onready var audio_stream_player:AudioStreamPlayer = $AudioStreamPlayer
@onready var death_music: AudioStreamPlayer = $DeathMusic
@onready var title_music: AudioStreamPlayer = $TitleMusic
@onready var victory_music: AudioStreamPlayer = $VictoryMusic

var quantizations := {
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

var elapsed:float :
  get:
    return (Time.get_ticks_usec() - time_begin) / 1_000_000.0 - time_delay
    
var length:float :
  get:
    return audio_stream_player.stream.get_length()
    
var progress:float :
  get:
    return max(self.elapsed / self.length, 0)

var time_begin := 0.0
var time_delay := 0.0

signal quarter(beat)
signal eighth(beat)
signal twelfth(beat)
signal sixteenth(beat)
signal twenty_fourth(beat)
signal thirty_second(beat)

func play_music() -> void:
  death_music.stop()
  title_music.stop()
  victory_music.stop()

  time_begin = Time.get_ticks_usec()
  time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
  audio_stream_player.play()
  
  beats = { 4: 0, 8: 0, 12: 0, 16: 0, 24: 0, 32: 0 }
  
func stop_music() -> void:
  audio_stream_player.stop()
  
func subdivision_duration(subdivision:int) -> float:
  return 60.0 / (bpm * (subdivision / 4))
  
func _ready() -> void:
  title_music.play()
  EventBus.player_died.connect(_on_player_died)

func _process(_delta: float) -> void:
  if !audio_stream_player.playing:
    return

  var time = elapsed
  if time < 0:
    time = 0
    return
  
  for subdivision in quantizations.keys():
    var nps:float = (subdivision / 4) * bpm / 60.0
    var current_note = floor(nps * time)
    if current_note > beats[subdivision]:
      beats[subdivision] = current_note
      quantizations[subdivision].emit(int(beats[subdivision]) % subdivision)

func _on_player_died(player:Player) -> void:
  stop_music()
  death_music.play()
