extends Label

func _ready() -> void:
  EventBus.measure_changed.connect(func(m): text = "%d" % m)
