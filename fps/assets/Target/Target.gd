extends RigidBody

signal hit

export var health = 100
var detectedPlayer = false

func _on_Target_hit(data):
	print('target hit')
	if(data.damage):
		health -= data.damage
		detectedPlayer = true
		if(health < 0):
			queue_free()

func _process(delta):
	if detectedPlayer:
		var player = get_node("../Player")
		if player and player.playable:
			var endposition = get_node("../Player").global_transform.origin;
			look_at(Vector3(endposition.x, translation.y, endposition.z), Vector3(0, 1, 0))


func _on_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		detectedPlayer = true
		print('Player detected')
		
