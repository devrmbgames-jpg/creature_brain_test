extends RefCounted
class_name GameBrainSituationBuilder



static func build(context: GameBrainContext, dna: GameBrainDNA) -> GameBrainSituation:
	var s := GameBrainSituation.new()

	s.need = _detect_need(context, dna)
	s.object_type = _detect_object_tag(context)
	s.distance = _detect_distance(context, dna)
	s.danger = _detect_danger(context)
	s.platform_above = context.platform_above

	return s


static func _detect_need(context: GameBrainContext, dna: GameBrainDNA) -> GameBrainSituation.Need:
	
	if context.fear > dna.limit_to_afraid :
		return GameBrainSituation.Need.AFRAID

	if context.hunger > dna.limit_to_hungry :
		return GameBrainSituation.Need.HUNGRY

	if context.energy < dna.limit_to_tired :
		return GameBrainSituation.Need.TIRED

	if context.fun < dna.limit_to_bored :
		return GameBrainSituation.Need.BORED

	if context.curiosity > dna.limit_to_curious :
		return GameBrainSituation.Need.CURIOUS

	return GameBrainSituation.Need.NEUTRAL


static func _detect_object_tag(context: GameBrainContext) -> StringName:
	if context.target_object == null:
		return GameBrainObjectInfo.Tags.NONE

	if context.target_object.tags.is_empty():
		return GameBrainObjectInfo.Tags.NONE

	return context.target_object.tags[0]


static func _detect_distance(context: GameBrainContext, dna: GameBrainDNA) -> GameBrainSituation.Distance:
	if context.target_object == null:
		return GameBrainSituation.Distance.NONE

	if context.target_object.distance < dna.near_distance:
		return GameBrainSituation.Distance.NEAR

	return GameBrainSituation.Distance.FAR


static func _detect_danger(context: GameBrainContext) -> GameBrainSituation.Danger:
	if context.cliff_ahead:
		return GameBrainSituation.Danger.CLIFF

	if context.wall_ahead:
		return GameBrainSituation.Danger.WALL

	return GameBrainSituation.Danger.SAFE
