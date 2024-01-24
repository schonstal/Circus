extends CharacterBody2D

@export_range(1, 1000) var speed := 300

func _process(delta: float) -> void:
  var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
  velocity = direction * speed

func _physics_process(delta: float) -> void:
  move_and_slide()
