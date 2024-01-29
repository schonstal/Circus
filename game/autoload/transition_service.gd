extends Node

signal transition_finished

func transition_in() -> void:
  GameService.game.transition.transition_in()
  await GameService.game.transition.transition_finished
  transition_finished.emit()

func transition_out() -> void:
  GameService.game.transition.transition_out()
  await GameService.game.transition.transition_finished
  transition_finished.emit()
