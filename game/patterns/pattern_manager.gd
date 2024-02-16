extends Node

func _ready() -> void:
  Conductor.quarter.connect(_on_quarter)

func _on_quarter(_measure_beat:int) -> void:
  var beat:int = Conductor.beats[4]
  var child:Node = find_child("%d" % beat)
  if child != null && child.has_method("activate"):
    child.activate()
