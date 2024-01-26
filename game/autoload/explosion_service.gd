extends Node

var explosion_scene:PackedScene = preload("res://game/hazard/projectile/explosion/explosion.tscn")

func spawn_explosion(global_position:Vector2) -> void:
  var explosion := explosion_scene.instantiate() as Explosion
  explosion.global_position = global_position
  GameService.game.explosions.add_child(explosion)
