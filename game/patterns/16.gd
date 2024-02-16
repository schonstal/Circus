extends Node

@onready var pin_spawner_2: Node = $PinSpawner2
@onready var pin_spawner: Node = $PinSpawner

func activate() -> void:
  pin_spawner.start()
  pin_spawner_2.start()
