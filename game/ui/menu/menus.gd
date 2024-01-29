extends Control

@onready var title: Control = $Title
@onready var game_over: Control = $GameOver
@onready var victory: Control = $Victory

func _ready() -> void:
  EventBus.player_died.connect(_on_player_died)
  
func _on_player_died(_player:Player) -> void:
  await get_tree().create_timer(2.6).timeout
  TransitionService.transition_out()
  await TransitionService.transition_finished
  game_over.activate()
