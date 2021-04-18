extends KinematicBody

signal pickup
signal status_change

export var gravity = -28.0
export var walk_speed = 14.0
export var jump_speed = 12.0
export var mouse_sensitivity = 0.002
export var acceleration = 4.0
export var friction = 6.0
export var fall_limit = -1000.0
export var health = 100

var gun = null
var pivot
var playable = true
var dir = Vector3.ZERO
var velocity = Vector3.ZERO

onready var gun1 = preload("res://assets/Gun/Gun.tscn")

func _ready():
	pivot = $pivot
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	equip_weapon(gun1.instance())
	
func equip_weapon(weapon):
	gun = weapon
	get_node("pivot/hand").add_child(gun)

func _physics_process(delta):
	dir = Vector3.ZERO
	var basis = global_transform.basis
	if Input.is_action_pressed("move_forward"):
		dir -= basis.z
	if Input.is_action_pressed("move_back"):
		dir += basis.z
	if Input.is_action_pressed("move_left"):
		dir -= basis.x
	if Input.is_action_pressed("move_right"):
		dir += basis.x
	dir = dir.normalized()
	
	var speed = walk_speed
	if is_on_floor():
		#this prevents you from sliding without messing up the is_on_ground() check
		velocity.y += gravity * delta / 100.0
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed
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
	if playable:
		velocity = move_and_slide(velocity, Vector3.UP, true)

	#prevents infinite falling
	if translation.y < fall_limit and playable:
		playable = false
		
	if gun and gun.can_shoot and Input.is_action_pressed("shoot"):
		gun.emit_signal("shoot")

	
#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()

func _unhandled_input(event):
	if event is InputEventMouseMotion and playable:
		rotate_y(-event.relative.x * mouse_sensitivity)
		pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		pivot.rotation.x = clamp(pivot.rotation.x, -1.2, 1.2)

func update_gui():
	var status = {"health": health}
	emit_signal("status_change", status)

func _on_Player_pickup(data):
	print('Pickup')
	print(data)
	if data["health"]:
		health += data.health
		
		
	update_gui()
	pass # Replace with function body.
