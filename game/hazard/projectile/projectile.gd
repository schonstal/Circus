class_name Projectile
extends Area2D

@export var index:int = 0

@export var velocity:Vector2

func _ready() -> void:
  body_entered.connect(_on_body_entered)
  EventBus.player_died.connect(_on_player_died)

func _physics_process(delta: float) -> void:
  position += velocity * delta

func _on_body_entered(body:Node2D) -> void:
  ExplosionService.spawn_explosion(global_position)
  queue_free()
  if body.has_method("hurt"):
    body.hurt(34)

func _on_player_died(_p:Player) -> void:
  queue_free()
