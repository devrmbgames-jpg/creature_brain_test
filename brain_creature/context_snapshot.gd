# context_snapshot.gd
extends RefCounted
class_name GameBrainContextSnapshot

var hunger := 0.0
var fun := 0.0
var energy := 0.0
var health := 0.0
var fear := 0.0
var stress := 0.0
var pleasure := 0.0

static func from_context(context: GameBrainContext) -> GameBrainContextSnapshot:
	var s := GameBrainContextSnapshot.new()
	s.hunger = context.hunger
	s.fun = context.fun
	s.energy = context.energy
	s.health = context.health
	s.fear = context.fear
	s.stress = context.stress
	s.pleasure = context.pleasure
	return s
