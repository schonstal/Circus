class_name Projectile
extends Area2D

@export var index:int = 0

var velocity:Vector2

func _ready() -> void:
  velocity = Vector2(sin(index)*50, cos(index)*50);
  body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
  rotation += delta * TAU
  
func _physics_process(delta: float) -> void:
  position += velocity * delta

func _on_body_entered(body:Node2D) -> void:
  ExplosionService.spawn_explosion(global_position)
  queue_free()
