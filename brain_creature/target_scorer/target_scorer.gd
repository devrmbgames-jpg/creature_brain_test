# target_scorer.gd
extends Node
class_name GameBrainTargetScorer


func _ready() -> void:
	var pool: GameBrainTargetSelector = get_parent() as GameBrainTargetSelector
	if pool :
		pool.scorers.append(self)



func _enter_tree() -> void:
	var pool: GameBrainTargetSelector = get_parent() as GameBrainTargetSelector
	if pool :
		pool.scorers.erase(self)


func get_score(
	_obj: GameBrainObjectInfo,
	_context: GameBrainContext,
	_dna: GameBrainDNA
) -> float:
	return 0.0
