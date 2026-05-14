# vision_sensor.gd
extends GameBrainSensor
class_name GameBrainSensorVision

@export var vision_area: Area3D
@export var look_raycast: RayCast3D

func sense(context: GameBrainContext) -> void:
	if vision_area == null:
		return

	for body in vision_area.get_overlapping_bodies():
		look_raycast.target_position = look_raycast.to_local(body.global_position)
		look_raycast.force_raycast_update()
		var colliding := look_raycast.get_collider()
		if colliding != body :
			continue
		
		var brain: GameBrain = context.get_parent() as GameBrain
		var root_node: Node3D = brain.root_node
		
		if body == root_node :
			continue
		
		var tags_component := GameComponent.get_component(body, C_Tags) as C_Tags
		if not tags_component :
			continue
		
		
		var tags: Array[StringName] = tags_component.get_tags()
		var distance := root_node.global_position.distance_to(body.global_position)
		
		var info := GameBrainObjectInfo.new(
			body,
			tags,
			body.global_position,
			distance
		)

		info.can_interact = distance < brain.dna.interract_distance

		context.visible_objects.append(info)
