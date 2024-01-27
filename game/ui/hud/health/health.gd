extends Control

@onready var health: TextureProgressBar = $Health
@onready var flash: TextureProgressBar = $Flash

var tween:Tween

func _ready() -> void:
  EventBus.player_health_changed.connect(_on_player_health_changed)

func _on_player_health_changed(player:Player, amount:float) -> void:
  if tween != null:
    tween.stop()
    
  health.value = player.health
  flash.tint_progress = Color(3, 3, 3)

  tween = get_tree().create_tween()
  tween.tween_property(flash, "tint_progress", Color(3, 3, 1), 0.2)
  tween.set_ease(Tween.EASE_OUT)
  tween.set_trans(Tween.TRANS_CUBIC)
  tween.set_parallel(false)
  tween.tween_property(flash, "value", player.health, 0.1)
