extends Node

var explosion_scene:PackedScene = preload("res://game/hazard/projectile/explosion/explosion.tscn")
var flower_scene:PackedScene = preload("res://game/hazard/projectile/flower/flower.tscn")

func spawn_explosion(global_position:Vector2) -> void:
  var explosion := explosion_scene.instantiate() as Explosion
  explosion.global_position = global_position
  GameService.game.explosions.add_child(explosion)

func spawn_flower(global_position:Vector2) -> void:
  var flower := flower_scene.instantiate()
  flower.global_position = global_position
  GameService.game.projectiles.add_child(flower)
