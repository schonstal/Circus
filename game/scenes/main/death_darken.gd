extends ColorRect

func _ready() -> void:
  EventBus.player_died.connect(_on_player_died)

func _on_player_died(p:Player) -> void:
  visible = true
