extends Node

@export var spawn_position := Vector2(480, 1200)
@export var velocity := Vector2(10, -10)
@export var acceleration := Vector2(0, 5)
@export var spawn_on_beat := 0

const JUGGLING_PIN = preload("res://game/hazard/projectile/juggling_pin/juggling_pin.tscn")

func start() -> void:
  Conductor.quarter.connect(_on_quarter)

func _on_quarter(beat:int) -> void:
  if beat % 2 != spawn_on_beat:
    return
  var pin := JUGGLING_PIN.instantiate()
  pin.velocity = velocity
  pin.acceleration = acceleration
  pin.global_position = spawn_position
  GameService.game.projectiles.add_child(pin)
