extends Node2D

@onready var head: Sprite2D = $Graphics/Head
@onready var mouf: Sprite2D = $Graphics/Mouf
@onready var face: Sprite2D = $Graphics/Face

var mouth_tween:Tween

func speak(duration:float = 0.2) -> void:
  if mouth_tween != null:
    mouth_tween.stop()

  mouth_tween = get_tree().create_tween()
  mouth_tween.set_ease(Tween.EASE_OUT)
  mouth_tween.set_trans(Tween.TRANS_QUART)
  mouth_tween.tween_property(mouf, "position", Vector2(0, 200), duration - 0.1)
  mouth_tween.tween_interval(duration - 0.2)
  mouth_tween.tween_property(mouf, "position", Vector2(0, 165), duration - 0.1)
