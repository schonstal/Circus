extends Projectile

enum Suit {
  CLUB,
  DIAMOND,
  HEART,
  SPADE
}

@export var suit:Suit

@onready var card: AnimatedSprite2D = $Card

func _ready() -> void:
  card.frame = suit
  super._ready()
  
func _process(delta: float) -> void:
  rotation = velocity.angle() + PI / 2
