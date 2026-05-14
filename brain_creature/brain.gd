extends Node
class_name GameBrain

@export var dna: GameBrainDNA = GameBrainDNA.new()
@export var wait_time_update := 1.0
@export var root_node: Node3D = null

var sensors: GameBrainSensorPool = null
var actions: GameBrainActionPool = null

var context: GameBrainContext = null

var memory: GameBrainMemory = null

var connections: Array[GameBrainConnection] = []
var connection_map: Dictionary[StringName, GameBrainConnection] = {}

var current_situation: GameBrainSituation = null
var current_action: GameBrainAction = null
var target_selector: GameBrainTargetSelector = null
var reward_model: GameBrainRewardModel = null



var _time_left_update := 0.0





func tick(delta: float) -> void:
	 
	if context == null or sensors == null or actions == null:
		return
	
	_update_context()
	_sense()
	_remember_visible_objects()
	
	var before := GameBrainContextSnapshot.from_context(context)
	
	current_situation = GameBrainSituationBuilder.build(context, dna)
	current_action = _choose_action(current_situation)
	
	#TODO action.run находится в _process и выполняется каждый тик
	
	# обучение
	if current_action and reward_model:
		var reward := reward_model.get_reward(
			before,
			context,
			current_action,
			current_situation,
			dna
		)
		
		_reinforce(current_situation.get_id(), current_action.action_id, reward)
	
	_decay_connections(delta)
	



func _physics_process(delta: float) -> void:
	
	if current_action != null:
		current_action.run(context, dna, delta)
	
	_time_left_update += delta
	if _time_left_update > wait_time_update :
		tick(_time_left_update)
		_time_left_update = 0.0

func _update_context() -> void:
	var hamster_attr := GameComponent.get_component(root_node, C_HamsterAttribute) as C_HamsterAttribute
	if hamster_attr :
		context.hunger = hamster_attr.hunger
		context.fun = hamster_attr.fun
		context.energy = hamster_attr.energy
		context.health = hamster_attr.health




func _sense() -> void:
	context.visible_objects.clear()
	context.heard_objects.clear()
	context.target_object = null
	
	context.cliff_ahead = false
	context.wall_ahead = false
	context.platform_above = false
	
	sensors.sense(context)
	
	_select_target_object()



func _select_target_object() -> void:
	if target_selector != null:
		context.target_object = target_selector.select_target(context, dna)


func _choose_action(situation: GameBrainSituation) -> GameBrainAction:
	var best_action: GameBrainAction = null
	var best_score := -999999.0
	
	for action_id in actions.action_map:
		var action: GameBrainAction = actions.action_map[action_id]
		if not action.can_run(context, dna):
			continue
	
		var score := action.get_base_score(context, dna)
		score += _get_connection_weight(situation.get_id(), action_id)
		score += _get_hormone_bias(action)
		score += randf_range(-dna.action_noise, dna.action_noise)
	
		if score > best_score:
			best_score = score
			best_action = action
	
	return best_action


func _get_connection_weight(situation_id: StringName, action_id: StringName) -> float:
	var c := _find_connection(situation_id, action_id)
	
	if c == null:
		c = _create_connection(situation_id, action_id)
	
	return c.weight


func _connection_key(situation_id: StringName, action_id: StringName) -> StringName:
	return StringName("%s=>%s" % [situation_id, action_id])


func _find_connection(situation_id: StringName, action_id: StringName) -> GameBrainConnection:
	var key := _connection_key(situation_id, action_id)
	if connection_map.has(key):
		return connection_map[key]
	return null


func _create_connection(situation_id: StringName, action_id: StringName) -> GameBrainConnection:
	var c := GameBrainConnection.new()
	c.situation_id = situation_id
	c.action_id = action_id
	c.weight = randf_range(dna.new_connection_min, dna.new_connection_max)
	connections.append(c)
	connection_map[_connection_key(situation_id, action_id)] = c
	return c



func _get_hormone_bias(action: GameBrainAction) -> float:
	return action.get_hormone_bias(context, dna)



func _reinforce(situation_id: StringName, action_id: StringName, reward: float) -> void:
	var c := _find_connection(situation_id, action_id)
	
	if c == null:
		c = _create_connection(situation_id, action_id)
	
	var learning_rate := dna.learning_rate
	
	c.weight += reward * learning_rate
	c.weight = clamp(c.weight, dna.connection_min_weight, dna.connection_max_weight)
	c.uses += 1



func _decay_connections(delta: float) -> void:
	for c in connections:
		c.age += delta
		c.weight = move_toward(c.weight, 0.0, delta * dna.connection_decay_speed)
	
	connections = connections.filter(func(c: GameBrainConnection) -> bool:
		return abs(c.weight) > dna.connection_remove_threshold or c.uses > dna.connection_keep_uses
	)


func _remember_visible_objects() -> void:
	for obj in context.visible_objects:
		memory.remember(obj)
