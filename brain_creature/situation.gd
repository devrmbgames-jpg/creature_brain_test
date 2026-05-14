extends RefCounted
class_name GameBrainSituation

enum Need {
	NEUTRAL,
	HUNGRY,
	TIRED,
	BORED,
	AFRAID,
	CURIOUS
}

enum Distance {
	NONE,
	NEAR,
	FAR
}

enum Danger {
	SAFE,
	CLIFF,
	WALL
}

var need: Need = Need.NEUTRAL
var object_type: StringName = GameBrainObjectInfo.Tags.NONE
var distance: Distance = Distance.NONE
var danger: Danger = Danger.SAFE
var platform_above := false


func get_id() -> StringName:
	return StringName("%s|%s|%s|%s|%s" % [
		Need.keys()[need],
		object_type,
		Distance.keys()[distance],
		Danger.keys()[danger],
		str(platform_above)
	])
