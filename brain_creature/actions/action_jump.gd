extends GameBrainAction
class_name GameBrainActionJump

func _ready() -> void:
	super()
	action_id = &"jump"


func can_run(context: GameBrainContext, _dna: GameBrainDNA) -> bool:
	return context.grounded and not context.cliff_ahead


func get_base_score(context: GameBrainContext, _dna: GameBrainDNA) -> float:
	if context.wall_ahead:
		return 0.5
	
	if context.platform_above and context.curiosity > 0.4:
		return 0.4
	
	return 0.0


func get_hormone_bias(_context: GameBrainContext, _dna: GameBrainDNA) -> float :
	return 0.0


func run(context: GameBrainContext, _dna: GameBrainDNA, _delta: float) -> void:
	var brain := context.get_parent() as GameBrain
	var root_node := brain.root_node
	var controller := GameComponent.get_component(root_node, C_Controller) as C_Controller
	if controller :
		controller.act_jump()
