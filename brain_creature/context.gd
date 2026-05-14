extends Node
class_name GameBrainContext



var visible_objects: Array[GameBrainObjectInfo] = []
var heard_objects: Array[GameBrainObjectInfo] = []

var target_object: GameBrainObjectInfo = null

var cliff_ahead := false
var wall_ahead := false
var ground_ahead := true
var grounded := false
var platform_above := false

var hunger := 0.0
var fun := 1.0
var energy := 1.0
var health := 1.0

var fear := 0.0
var curiosity := 0.0
var stress := 0.0
var pleasure := 0.0




func _ready() -> void:
	var brain: GameBrain = get_parent() as GameBrain
	if brain :
		brain.context = self
