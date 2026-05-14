extends Resource
class_name GameBrainMemoryItem

@export var tags: Array[StringName] = []
@export var position: Vector3 = Vector3.ZERO
@export var usefulness := 0.0
@export var danger := 0.0
@export var last_seen_time := 0


func contain_tags_all(with: Array[StringName]) -> bool :
	if with.is_empty() :
		return false
	
	for tag in with :
		if not tag in tags :
			return false
	
	return true

func ontain_tags_any(with: Array[StringName]) -> bool :
	if with.is_empty() :
		return false
	
	for tag in with :
		if tag in tags :
			return true
	
	return false
