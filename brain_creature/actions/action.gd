extends Node
class_name GameBrainAction

@export var action_id: StringName = &""

func _ready() -> void:
	var pool: GameBrainActionPool = get_parent() as GameBrainActionPool
	if pool :
		pool.action_map[action_id] = self



func _enter_tree() -> void:
	var pool: GameBrainActionPool = get_parent() as GameBrainActionPool
	if pool :
		pool.action_map.erase(action_id)


func can_run(_context: GameBrainContext, _dna: GameBrainDNA) -> bool:
	return true


func get_base_score(_context: GameBrainContext, _dna: GameBrainDNA) -> float:
	return 0.0


func run(_context: GameBrainContext, _dna: GameBrainDNA, _delta: float) -> void:
	pass


func get_hormone_bias(_context: GameBrainContext, _dna: GameBrainDNA) -> float :
	
	return 0.0
