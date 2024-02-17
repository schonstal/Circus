class_name Projectile
extends Area2D

@export var index:int = 0

@export var velocity:Vector2

func _ready() -> void:
  body_entered.connect(_on_body_entered)
  EventBus.player_died.connect(_on_player_died)
  EventBus.flower_time.connect(_its_flower_time)
  
func _process(delta: float) -> void:
  if global_position.x < -400 || global_position.x > 2320 || global_position.y < -400 || global_position.y > 1480:
    queue_free()

func _physics_process(delta: float) -> void:
  position += velocity * delta

func _on_body_entered(body:Node2D) -> void:
  ExplosionService.spawn_explosion(global_position)
  queue_free()
  if body.has_method("hurt"):
    body.hurt(34)

func _on_player_died(_p:Player) -> void:
  queue_free()

func _its_flower_time() -> void:
  ExplosionService.spawn_flower(global_position)
  queue_free()
