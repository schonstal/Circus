@tool
extends Node2D

@onready var hand: Sprite2D = $Hand

@export var flip:bool = false
    
@export_range(0, 5) var speed:float = 1.0
@export_range(0, 50) var radius:float = 20.0

func _ready() -> void:
  hand.flip_h = flip

func _process(delta: float) -> void:
  var seconds = Time.get_ticks_msec() / 1_000.0
  var theta = seconds * TAU * speed

  if flip:
    hand.offset = Vector2(
      sin(theta) * radius,
      cos(theta) * radius
    )
  else:
    hand.offset = Vector2(
      cos(theta) * radius,
      sin(theta) * radius
    )
