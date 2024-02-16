extends PathFollow2D

@export var seconds:float = 1.0

func _ready() -> void:
  await get_tree().create_timer(2.0).timeout
  follow_path()

func follow_path() -> void:
  var tween := get_tree().create_tween()
  tween.set_trans(Tween.TRANS_LINEAR)
  tween.tween_property(self, "progress_ratio", 1.0, seconds)
