extends CharacterBody2D

@export_range(1, 1000) var speed := 300

func _process(delta: float) -> void:
  #position = get_viewport().get_mouse_position()
  calculate_velocity_from_joypad()
  constrain_to_arena()
  
func constrain_to_arena() -> void:
  var center := get_viewport_rect().size / 2.0
  if center.distance_to(position) > 400:
    position = center + (position - center).normalized() * 400
  
func calculate_velocity_from_joypad() -> void:
  var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
  velocity = direction * speed

func _physics_process(delta: float) -> void:
  move_and_slide()
