extends Node

var game:Game
var player:Player

signal root_changed(root:Game)

func register_root(node:Game) -> void:
  game = node
  root_changed.emit(game)

func start() -> void:
  game.start()
