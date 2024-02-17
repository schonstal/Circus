extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var _16: Node = $"../16"
@onready var _32: Node = $"../32"
@onready var head: Node2D = $"../../Head"

func activate() -> void:
  animation_player.play("disappear")
  _16.queue_free()
  _32.queue_free()
  await get_tree().create_timer(0.1).timeout
  EventBus.flower_time.emit()
  await animation_player.animation_finished
  head.queue_free()
