# target_selector.gd
extends Node
class_name GameBrainTargetSelector

var scorers: Array[GameBrainTargetScorer] = []

func _ready() -> void:
	var brain: GameBrain = get_parent() as GameBrain
	if brain :
		brain.target_selector = self
	


func select_target(context: GameBrainContext, dna: GameBrainDNA) -> GameBrainObjectInfo:
	var best: GameBrainObjectInfo = null
	var best_score := -INF

	for obj in context.visible_objects:
		var score := 0.0

		for scorer in scorers:
			score += scorer.get_score(obj, context, dna)

		if score > best_score:
			best_score = score
			best = obj

	return best
