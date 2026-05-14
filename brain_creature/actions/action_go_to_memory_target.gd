# actions/action_go_to_memory_target.gd
extends GameBrainAction
class_name GameBrainActionGoToMemoryTarget

# список тегов, по которым ищем записи в памяти
@export var target_tags: Array[StringName] = [GameBrainObjectInfo.Tags.FOOD]


# считаем цель достигнутой, когда расстояние меньше этого значения
@export var reach_distance: float = 0.1


func _ready() -> void:
	super()
	action_id = &"go_to_memory_target"


func can_run(context: GameBrainContext, dna: GameBrainDNA) -> bool:
	# выполняем этот экшен только если нет текущего видимого объекта‑цели
	if context.target_object != null:
		return false
	
	# получаем ссылки на мозг и память
	var brain := context.get_parent() as GameBrain
	if brain == null or brain.memory == null:
		return false
	
	# проверяем наличие нужных тегов в памяти
	var has_any := false
	for tag in target_tags:
		if brain.memory.has_object_tag(tag):
			has_any = true
			break
	if not has_any:
		return false
	
	# можно добавить проверку драйва (например, для еды — сильный голод)
	for tag in target_tags:
		if tag == GameBrainObjectInfo.Tags.FOOD and context.hunger <= dna.limit_to_hungry:
			return false
	
	return true


func get_base_score(context: GameBrainContext, dna: GameBrainDNA) -> float:
	var score := dna.score_act_base_mem  # базовая ценность перехода к памяти
	for tag in target_tags:
		match tag:
			GameBrainObjectInfo.Tags.FOOD:
				score += context.hunger * dna.score_act_hunger
			GameBrainObjectInfo.Tags.WHEEL:
				score += (dna.score_act_fun - context.fun) * dna.score_act_wheel
			GameBrainObjectInfo.Tags.DRINKER:
				# для поилки можно использовать ту же мотивацию, что и для еды
				score += context.hunger * dna.score_act_drinker
			_:
				pass
	return score


func run(context: GameBrainContext, dna: GameBrainDNA, _delta: float) -> void:
	var brain := context.get_parent() as GameBrain
	if brain == null or brain.memory == null or brain.root_node == null:
		return
	
	var root_node := brain.root_node
	
	# определяем позицию существа и выбираем лучшее воспоминание
	var from_pos: Vector3 = root_node.global_position
	var best_item := brain.memory.find_best(target_tags, from_pos, dna)
	
	if best_item == null:
		return
	
	var distance := from_pos.distance_to(best_item.position)
	var direction := from_pos.direction_to(best_item.position)
	
	if distance < reach_distance:
		return
	
	# нормализуем направление и перемещаемся
	direction = direction.normalized()
	
	var controller := GameComponent.get_component(root_node, C_Controller) as C_Controller
	if controller :
		controller.motion = direction
		
		direction.z = 0.0
		direction = direction.normalized()
		controller.direction = direction
		
	
