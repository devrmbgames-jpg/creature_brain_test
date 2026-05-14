extends Node
class_name GameBrainSensorPool

var sensors: Array[GameBrainSensor] = []

func _ready() -> void:
	var brain := get_parent() as GameBrain
	if brain :
		brain.sensors = self



func sense(context: GameBrainContext) -> void:
	for sensor in sensors :
		sensor.sense(context)
