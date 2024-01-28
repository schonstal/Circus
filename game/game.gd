class_name Game
extends Node2D

@onready var explosions: Node2D = %Explosions
@onready var projectiles: Node2D = %Projectiles
@onready var transition: Node2D = %Transition

func _ready() -> void:
  GameService.register_root(self)
