extends Sprite2D

@export var color_dark:Color = Color("fbee4a")
@export var color_light:Color = Color.WHITE

func _ready() -> void:
  Conductor.sixteenth.connect(_on_sixteenth)
  Conductor.play_music()

func _on_sixteenth(beat:int) -> void:
  if beat % 2 == 0:
    self_modulate = color_dark
  else:
    self_modulate = color_light
