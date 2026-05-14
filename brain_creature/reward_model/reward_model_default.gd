# default_reward_model.gd
extends GameBrainRewardModel
class_name GameBrainDefaultRewardModel

func get_reward(
	before: GameBrainContextSnapshot,
	after: GameBrainContext,
	_action: GameBrainAction,
	_situation: GameBrainSituation,
	dna: GameBrainDNA
) -> float:
	var reward := 0.0

	reward += (before.hunger - after.hunger) * dna.reward_hunger
	reward += (after.fun - before.fun) * dna.reward_fun
	reward += (after.energy - before.energy) * dna.reward_energy
	reward += (after.health - before.health) * dna.reward_health

	return reward
