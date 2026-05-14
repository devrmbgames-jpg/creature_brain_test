# food_target_scorer.gd
extends GameBrainTargetScorer
class_name GameBrainFoodTargetScorer

@export var hunger_weight := 2.0

func get_score(
	obj: GameBrainObjectInfo,
	context: GameBrainContext,
	_dna: GameBrainDNA
) -> float:
	if not GameBrainObjectInfo.Tags.FOOD in obj.tags:
		return 0.0

	return context.hunger * hunger_weight
