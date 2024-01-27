extends TextureProgressBar

var tween:Tween

func _ready() -> void:
  EventBus.player_health_changed.connect(_on_player_health_changed)

func _on_player_health_changed(player:Player, amount:float) -> void:
  if tween != null:
    tween.stop()

  tween = get_tree().create_tween()
  tween.tween_property(self, "value", value + 5, 0.05)
  tween.set_ease(Tween.EASE_IN)
  tween.set_trans(Tween.TRANS_QUAD)
  tween.tween_property(self, "value", player.health, 0.2)
  tween.set_ease(Tween.EASE_OUT)
  tween.set_trans(Tween.TRANS_BOUNCE)
