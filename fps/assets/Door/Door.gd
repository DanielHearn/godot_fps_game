extends Spatial

var y = 0
var maxOpen = 1.8
var speed = 3
var colliding_entities = 0

func _physics_process(delta):
	var delta_speed = speed * delta
	if colliding_entities > 0 and y < maxOpen:
		y += delta_speed
		get_node("door_inside").translate_object_local(Vector3(0, delta_speed, 0))
	elif colliding_entities == 0 and y > delta_speed:
		y -= delta_speed
		get_node("door_inside").translate_object_local(Vector3(0, -delta_speed, 0))


func _on_Area_body_entered(body):
	if body.is_in_group("entities"):
		colliding_entities += 1


func _on_Area_body_exited(body):
	if body.is_in_group("entities"):
		colliding_entities -= 1
