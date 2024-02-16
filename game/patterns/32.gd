extends Node

const CARD = preload("res://game/hazard/projectile/card/card.tscn")
const CARD_BLUE = preload("res://game/hazard/projectile/card/card_blue.tscn")

@onready var head: Node2D = $"../../Head"

func activate() -> void:
  Conductor.sixteenth.connect(_on_sixteenth)

func _on_sixteenth(beat:int) -> void:
  var mod = 4
  var mouth_speed = 0.2
  if Conductor.beats[4] >= 48:
    mod = 2
  if Conductor.beats[4] >= 55:
    mod = 1
    mouth_speed = 0.1
    
  if beat % mod == 0:
    head.speak(mouth_speed)
    var instance:Projectile
    if int(Conductor.beats[4]) % 2 == 0:
      instance = CARD_BLUE.instantiate() as Projectile
    else:
      instance = CARD.instantiate() as Projectile
  
    instance.global_position = head.graphics.global_position + Vector2(0, 200)
    instance.velocity = Vector2(sin(2*beat / TAU + PI / 2), abs(cos(2*beat / TAU + PI / 2))) * 200
    GameService.game.projectiles.add_child(instance)
