class_name Game
extends Node2D

@onready var explosions: Node2D = %Explosions
@onready var projectiles: Node2D = %Projectiles

func _ready() -> void:
  GameService.register_root(self)
