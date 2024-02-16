class_name CameraShaker
extends Node

@export var noise:Noise
@export var translation := Vector2(100, 100)
@export var rotation := 25.0
@export var decay:Curve
@export var speed := 2.0
@export var zoom := 0.01

var time := 0.0
var amplitude := 0.0
var seed := 0.0
var strength := Vector2(0.0, 0.0)

@onready var camera:Camera2D = $'..'

func shake(amount:Vector2, duration:float) -> void:
  strength = amount
  speed = 1.0 / duration
  amplitude = 1
  time = 0
  seed = randf()

func _process(delta) -> void:
  time += delta * speed
  var p := time + seed
  var offset := strength * amplitude
  
  camera.offset.x = noise.get_noise_3d(p, 0, 0) * offset.x
  camera.offset.y = noise.get_noise_3d(0, p, 0) * offset.y
  camera.zoom = 0.0001 * offset + Vector2.ONE

  amplitude = clamp(decay.sample(time), 0, 1)
