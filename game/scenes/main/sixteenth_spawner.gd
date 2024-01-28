extends Node2D

@export var projectile:PackedScene
@export var invert:bool = false

func _ready() -> void:
  Conductor.sixteenth.connect(_on_sixteenth)

func _on_sixteenth(beat:int) -> void:
  var instance:Projectile = projectile.instantiate() as Projectile
  instance.global_position = global_position
  instance.velocity = Vector2(abs(sin(2*beat / TAU)), cos(2*beat / TAU)) * 200
  instance.rotation = instance.velocity.angle() + PI/2
  if invert:
    instance.velocity.x *= -1
    instance.rotation *= -1
  GameService.game.projectiles.add_child(instance)
