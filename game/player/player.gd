class_name Player
extends CharacterBody2D

@onready var graphics: AnimatedSprite2D = $Graphics
@onready var hitbox_visual: Sprite2D = $HitboxVisual
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurt_sound: AudioStreamPlayer = $HurtSound
@onready var spotlight: Sprite2D = $Spotlight

@export_range(1, 1000) var speed := 300.0
@export_range(1, 1000) var focus_speed := 150.0

var health := 100
var dead := false

func _process(delta: float) -> void:
  if dead:
    velocity = Vector2.ZERO
    return

  var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
  
  if Input.is_action_pressed("focus"):
    hitbox_visual.visible = true
    velocity = direction * focus_speed
  else:
    hitbox_visual.visible = false
    velocity = direction * speed
  
  if direction.length_squared() > 0:
    graphics.flip_h = direction.x > 0

func _physics_process(delta: float) -> void:
  move_and_slide()

  var center := get_viewport_rect().size / 2.0
  if center.distance_to(position) > 400:
    position = center + (position - center).normalized() * 400

func hurt(amount:int) -> void:
  if dead:
    return

  var health_was := health
  health = max(health - amount, 0)
  EventBus.player_health_changed.emit(self, health - health_was)
  
  if health <= 0:
    die()
  
  graphics.play("damaged")
  hurt_sound.play()
  
func die() -> void:
  hitbox_visual.visible = false
  dead = true
  spotlight.visible = true
  EventBus.player_died.emit(self)

func _on_graphics_animation_finished() -> void:
  if graphics.animation == "damaged":
    if dead:
      animation_player.play("die")
    else:
      graphics.play("run")
    
