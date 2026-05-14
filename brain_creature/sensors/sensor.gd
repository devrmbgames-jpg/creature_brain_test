extends Node
class_name GameBrainSensor

func _ready() -> void:
	var pool: GameBrainSensorPool = get_parent() as GameBrainSensorPool
	if pool :
		pool.sensors.append(self)

func _enter_tree() -> void:
	var pool: GameBrainSensorPool = get_parent() as GameBrainSensorPool
	if pool :
		pool.sensors.erase(self)

func sense(_context: GameBrainContext) -> void:
	pass
