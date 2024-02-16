@icon("res://util/state_machine/icons/state_machine.svg")
class_name StateMachine
extends Node
# Generic State Machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.

@export var initial_state:State

@onready var state:State = initial_state:
  set(value):
    state = value
    _state_name = state.name
    
@onready var _state_name := state.name
var state_path := _state_name

func _init() -> void:
  add_to_group("state_machine")

func _ready() -> void:
  await(owner.ready)
  state.enter()

func _unhandled_input(event: InputEvent) -> void:
  state._unhandled_input(event)

func _physics_process(delta: float) -> void:
  state._physics_process(delta)

func _process(delta: float) -> void:
  state._process(delta)

func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
  if !has_node(target_state_path):
    return

  var target_state := get_node(target_state_path)

  state.exit()
  self.state = target_state
  state.enter(msg)
