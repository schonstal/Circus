@icon("res://util/state_machine/icons/state.svg")
class_name State
extends Node
# State interface to use in Hierarchical State Machines.
# The lowest leaf tries to handle callbacks, and if it can't, it delegates the work to its parent.
# It's up to the user to call the parent state's functions, e.g. `_parent._physics_process(delta)`
# Use State as a child of a StateMachine node.

@onready var _state_machine:StateMachine = _get_state_machine(self)
var _parent:State = null

func _ready() -> void:
  set_process(false)
  set_physics_process(false)
  set_process_unhandled_input(false)
  
  await(owner.ready)
  _parent = get_parent() as State

func _unhandled_input(_event: InputEvent) -> void:
  pass

func _physics_process(_delta: float) -> void:
  pass
  
func _process(_delta: float) -> void:
  pass

func enter(_msg: Dictionary = {}) -> void:
  pass

func exit() -> void:
  pass

func _get_state_machine(node: Node) -> StateMachine:
  if node != null and !node.is_in_group("state_machine"):
    return _get_state_machine(node.get_parent())
  return node as StateMachine
