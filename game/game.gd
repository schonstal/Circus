class_name Game
extends Node2D

@export var arena_scene: PackedScene = preload("res://game/arena/arena.tscn")

@onready var world: Node2D = $World
@onready var transition: Node2D = %Transition

var arena:Arena

var projectiles: Node2D :
  get:
    return arena.projectiles
    
var explosions: Node2D :
  get:
    return arena.explosions

func _ready() -> void:
  GameService.register_root(self)
  
func start() -> void:
  for child in world.get_children():
    child.queue_free()
  arena = arena_scene.instantiate()
  world.add_child(arena)
  
  Conductor.play_music()
