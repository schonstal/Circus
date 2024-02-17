extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var started := false
var collected := false

func _ready() -> void:
  await get_tree().create_timer(1.644).timeout
  started = true

func _process(delta: float) -> void:
  if started:
    global_position = lerp(
      global_position,
      GameService.player.global_position,
      delta * 5
    )
  else:
    global_position.y -= 10 * delta
    
  if global_position.distance_to(GameService.player.global_position) < 50 && !collected:
    started = false
    collected = true
    get_tree().create_timer(1.0)
    queue_free()
