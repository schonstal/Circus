extends Node

var game:Game

signal root_changed(root:Game)

func register_root(node:Game) -> void:
  game = node
  root_changed.emit(game)
