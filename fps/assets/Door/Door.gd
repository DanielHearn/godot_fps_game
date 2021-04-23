extends Spatial

var open = false
var y = 0
var maxOpen = 1.8
var speed = 3

func _process(delta):
	var delta_speed = speed * delta
	if open and y < maxOpen:
		y += delta_speed
		get_node("door_inside").translate_object_local(Vector3(0, delta_speed, 0))
	elif not open and y > delta_speed:
		y -= delta_speed
		get_node("door_inside").translate_object_local(Vector3(0, -delta_speed, 0))


func _on_Area_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("enemies"):
		open = true


func _on_Area_body_exited(body):
	if body.is_in_group("player") or body.is_in_group("enemies"):
		open = false
