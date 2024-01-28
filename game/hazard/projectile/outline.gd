extends Sprite2D

@onready var original_color:Color = modulate

func _ready() -> void:
  Conductor.sixteenth.connect(_on_sixteenth)

func _on_sixteenth(beat:int) -> void:
  if beat % 2 > 0:
    modulate = original_color
  else:
    modulate = Color.WHITE
