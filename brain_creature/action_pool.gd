extends Node
class_name GameBrainActionPool

var action_map: Dictionary[StringName, GameBrainAction] = {}


func _ready() -> void:
	var brain := get_parent() as GameBrain
	if brain :
		brain.actions = self
