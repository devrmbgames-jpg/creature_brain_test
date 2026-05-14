# brain_dna.gd
extends Resource
class_name GameBrainDNA

@export_subgroup("Situation limits")
@export var limit_to_afraid := 0.6
@export var limit_to_hungry := 0.65
@export var limit_to_tired := 0.25
@export var limit_to_bored := 0.35
@export var limit_to_curious := 0.6
@export var near_distance := 3.0

@export_subgroup("Learning")
@export var learning_rate := 0.15
@export var connection_min_weight := -1.0
@export var connection_max_weight := 1.0
@export var connection_decay_speed := 0.001
@export var connection_remove_threshold := 0.01
@export var connection_keep_uses := 3

@export_subgroup("Randomness")
@export var action_noise := 0.03
@export var new_connection_min := -0.05
@export var new_connection_max := 0.05

@export_subgroup("Reward")
@export var reward_hunger := 2.0
@export var reward_fun := 1.0
@export var reward_energy := 1.0
@export var reward_health := 3.0


@export_subgroup("Memory")
@export var memory_usefulness_weight := 2.0
@export var memory_danger_weight := 2.0
@export var memory_age_penalty := 0.02
@export var memory_distance_penalty := 0.001



@export_subgroup("Score Action")
@export var score_act_base_mem := 0.5
@export var score_act_drinker := 0.5
@export var score_act_fun := 1.0
@export var score_act_wheel := 1.0
@export var score_act_hunger := 1.0




@export_subgroup("Interract")
@export var interract_distance := 0.7
