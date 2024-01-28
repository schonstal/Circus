class_name Projectile
extends Area2D

@export var index:int = 0

var velocity:Vector2

func _ready() -> void:
  body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
  position += velocity * delta

func _on_body_entered(body:Node2D) -> void:
  ExplosionService.spawn_explosion(global_position)
  if body.has_method("hurt"):
    body.hurt(34)
