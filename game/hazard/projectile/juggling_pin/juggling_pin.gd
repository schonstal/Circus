extends Projectile

@export var acceleration := Vector2.ZERO

func _ready() -> void:
  Conductor.quarter.connect(_on_quarter)

func _process(delta: float) -> void:
  rotation = PI * Conductor.elapsed / 0.411
  
func _physics_process(delta: float) -> void:
  velocity += acceleration * 0.5 * delta
  position += velocity
  velocity += acceleration * 0.5 * delta

func _on_quarter(_beat:int) -> void:
  var pulse_tween = get_tree().create_tween()
  scale = Vector2(1.2, 1.2)
  modulate = Color(4, 4, 4)
  pulse_tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
  pulse_tween.set_ease(Tween.EASE_IN)
  pulse_tween.set_trans(Tween.TRANS_QUAD)
  pulse_tween.set_parallel(true)
  pulse_tween.tween_property(self, "modulate", Color.WHITE, 0.1)
