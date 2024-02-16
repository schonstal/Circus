extends State

@onready var graphics: Node2D = %Graphics

func enter(state:Dictionary = {}) -> void:
  Conductor.quarter.connect(_on_quarter)
  
func exit() -> void:
  Conductor.quarter.disconnect(_on_quarter)

func _on_quarter(beat:int) -> void:
  if Conductor.beats[4] < 15:
    return
  var tween:Tween = get_tree().create_tween()
  var angle = cos(PI * (beat % 2))
  tween.tween_interval(0.205)
  tween.tween_property(graphics, "position", Vector2(20 * angle, 0), 0.206)
  tween.set_ease(Tween.EASE_IN)
  tween.set_trans(Tween.TRANS_QUART)
