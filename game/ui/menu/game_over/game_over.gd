extends Control

var active := false

func activate() -> void:
  active = true
  visible = true

func _process(delta: float) -> void:
  if active && Input.is_action_just_pressed("focus"):
    visible = false
    TransitionService.transition_in()
    active = false
    GameService.start()
