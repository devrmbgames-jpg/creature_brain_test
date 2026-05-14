extends Node
class_name GameBrainMemory


@export var items: Array[GameBrainMemoryItem] = []
@export var max_items := 30


func _ready() -> void:
	var brain: GameBrain = get_parent() as GameBrain
	if brain :
		brain.memory = self


func remember(info: GameBrainObjectInfo) -> void:
	var item := GameBrainMemoryItem.new()
	item.tags = info.tags
	item.position = info.position
	item.last_seen_time = Time.get_ticks_msec()
	
	items.push_front(item)
	
	while items.size() > max_items:
		items.pop_back()



func has_object_tag(tag: StringName) -> bool:
	for item in items:
		if tag in item.tags:
			return true

	return false



func find_best(tags: Array[StringName], from_position: Vector3, dna: GameBrainDNA) -> GameBrainMemoryItem:
	var best: GameBrainMemoryItem = null
	var best_score := -999999.0
	var now := Time.get_ticks_msec()

	for item in items:
		if not item.contain_tags_all(tags) :
			continue

		var age := float(now - item.last_seen_time) / 1000.0
		var distance := from_position.distance_to(item.position)

		var score := 0.0
		score += item.usefulness * dna.memory_usefulness_weight
		score -= item.danger * dna.memory_danger_weight
		score -= age * dna.memory_age_penalty
		score -= distance * dna.memory_distance_penalty

		if score > best_score:
			best_score = score
			best = item

	return best
