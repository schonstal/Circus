extends Node

@onready var head: Node2D = $"../../Head"

func activate() -> void:
  Conductor.eighth.connect(_on_eighth)
  
func _on_eighth(beat:int) -> void:
  if Conductor.beats[4] > 12:
    queue_free()
    return

  if beat % 2 == 0 || Conductor.beats[4] == 8:
    head.speak()
