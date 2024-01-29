extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var active := true

func _process(delta: float) -> void:
  if active && Input.is_action_just_pressed("focus"):
    TransitionService.transition_out()
    active = false
    animation_player.play("start")
    GameService.start()
