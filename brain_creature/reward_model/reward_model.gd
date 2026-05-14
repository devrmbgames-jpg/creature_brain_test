# reward_model.gd
extends Node
class_name GameBrainRewardModel


func _ready() -> void:
	var brain: GameBrain = get_parent() as GameBrain
	if brain :
		brain.reward_model = self

func get_reward(
	_before: GameBrainContextSnapshot,
	_after: GameBrainContext,
	_action: GameBrainAction,
	_situation: GameBrainSituation,
	_dna: GameBrainDNA
) -> float:
	return 0.0
