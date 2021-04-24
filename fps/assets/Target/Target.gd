extends KinematicBody

signal hit

export var health = 100
export var walk_speed = 5
var detectedPlayer = false
var dir = Vector3.ZERO
var velocity = Vector3.ZERO
export var gravity = -28.0
export var acceleration = 2.0
export var friction = 6.0

func _on_Target_hit(data):
	if(data.damage):
		health -= data.damage
		detectedPlayer = true
		if(health <= 0):
			queue_free()
			

func _physics_process(delta):
	dir = Vector3.ZERO
	var basis = global_transform.basis
	if detectedPlayer:
		var player = get_node("../Player")
		if player and player.playable:
			var endposition = get_node("../Player").global_transform.origin;
			look_at(Vector3(endposition.x, translation.y, endposition.z), Vector3(0, 1, 0))
			dir -= basis.z

	var speed = walk_speed
	if is_on_floor():
		velocity.y += gravity * delta / 100.0
	else:
		velocity.y += gravity * delta

	var hvel = velocity
	hvel.y = 0.0
	var target = dir * speed
	var accel
	if dir.dot(hvel) > 0.0:
		accel = acceleration
	else:
		accel = friction
	hvel = hvel.linear_interpolate(target, accel * delta)
	velocity.x = hvel.x
	velocity.z = hvel.z
	velocity = move_and_slide(velocity, Vector3.UP, true)

func _on_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		detectedPlayer = true
		
