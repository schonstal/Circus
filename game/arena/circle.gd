extends Node2D

@onready var texture_rect: TextureRect = $TextureRect

var radius: float = 1 :
  set(value):
    (texture_rect.material as ShaderMaterial).set_shader_parameter("radius", value)

func _ready() -> void:
  EventBus.measure_changed.connect(_pump)
  
func _pump(m:int):
  var t = create_tween()
  t.tween_method(_update_radius, 0.9, 0.8, 0.1)
  t.set_ease(Tween.EASE_IN)
  
func _update_radius(r:float):
  self.radius = r
