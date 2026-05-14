extends Resource
class_name GameBrainObjectInfo

const Tags := {
	NONE = &"NONE",
	FOOD = &"FOOD",
	HAMSTER = &"HAMSTER",
	WATER = &"WATER",
	WHEEL = &"WHEEL",
	DRINKER = &"DRINKER",
	DANGER = &"DANGER"
}


var node: Node3D = null
var tags: Array[StringName] = []
var position: Vector3 = Vector3.ZERO
var distance := 0.0
var can_interact := false

func _init(
		p_node: Node3D = null,
		p_tags: Array[StringName] = [],
		p_position: Vector3 = Vector3.ZERO,
		p_distance: float = 0.0
) -> void:
	node = p_node
	tags = p_tags
	position = p_position
	distance = p_distance
