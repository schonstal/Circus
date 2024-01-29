@tool
extends Sprite2D

@export var center:Vector2 = Vector2(960,540)
@export var frequency:Vector2 = Vector2(1, 2)
@export var radius:Vector2 = Vector2(300, 300)

var theta:Vector2 = Vector2(0,0)

func _process(delta: float) -> void:
  var theta:Vector2 = frequency * (Time.get_ticks_msec() / 1_000.0) * TAU
  
  position = Vector2(sin(theta.x), cos(theta.y)) * radius + center
