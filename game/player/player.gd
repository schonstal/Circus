class_name Player
extends CharacterBody2D

@onready var graphics: AnimatedSprite2D = $Graphics
@onready var hitbox_visual: Sprite2D = $HitboxVisual

@export_range(1, 1000) var speed := 300.0
@export_range(1, 1000) var focus_speed := 150.0

var health := 100

func _process(delta: float) -> void:
  var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
  
  if Input.is_action_pressed("focus"):
    hitbox_visual.visible = true
    velocity = direction * focus_speed
  else:
    hitbox_visual.visible = false
    velocity = direction * speed

func _physics_process(delta: float) -> void:
  move_and_slide()

  var center := get_viewport_rect().size / 2.0
  if center.distance_to(position) > 400:
    position = center + (position - center).normalized() * 400

func hurt(amount:int) -> void:
  var health_was := health
  health = max(health - amount, 0)
  EventBus.player_health_changed.emit(self, health - health_was)
  
  graphics.play("damaged")

func _on_graphics_animation_finished() -> void:
  if graphics.animation == "damaged":
    graphics.play("run")
