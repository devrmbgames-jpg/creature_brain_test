# distance_target_scorer.gd
extends GameBrainTargetScorer
class_name GameBrainDistanceTargetScorer

@export var distance_penalty := 0.001

func get_score(
	obj: GameBrainObjectInfo,
	_context: GameBrainContext,
	_dna: GameBrainDNA
) -> float:
	return -obj.distance * distance_penalty
