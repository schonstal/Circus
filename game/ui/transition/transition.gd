extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal transition_finished

func transition_in() -> void:
  animation_player.play("transition")
  await animation_player.animation_finished
  transition_finished.emit()

func transition_out() -> void:
  animation_player.play_backwards("transition")
  await animation_player.animation_finished
  transition_finished.emit()
