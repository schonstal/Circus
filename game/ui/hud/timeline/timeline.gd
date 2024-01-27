extends Control

@onready var bar: TextureRect = $Bar
@onready var rabbit: Sprite2D = $Rabbit
@onready var start: Marker2D = $Start
@onready var end: Marker2D = $End

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  rabbit.position = start.position
  Conductor.quarter.connect(_on_quarter)

func _process(delta: float) -> void:
  pass

func _on_quarter(_beat:int) -> void:
  var tween := get_tree().create_tween()
  rabbit.scale = Vector2(1.1, 1.1)
  var new_position:Vector2 = lerp(start.position, end.position, Conductor.progress)
  tween.tween_property(rabbit, "position", new_position, 0.1)
  tween.set_ease(Tween.EASE_OUT)
  tween.set_trans(Tween.TRANS_CUBIC)
  tween.set_parallel(true)
  tween.tween_property(rabbit, "scale", Vector2(1, 1), 0.2)
