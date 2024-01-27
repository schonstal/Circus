extends Sprite2D

func _ready() -> void:
  Conductor.quarter.connect(_pulse)

func _pulse(m:int) -> void:
  var tween := get_tree().create_tween()
  scale = Vector2(1, 1)
  tween.tween_property(self, "scale", Vector2(0.7, 0.7), 0.05)
  tween.set_ease(Tween.EASE_OUT)
  tween.set_trans(Tween.TRANS_CUBIC)
