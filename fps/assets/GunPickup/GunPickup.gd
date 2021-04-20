extends Area


export var gun = 1
onready var spinner = get_node("spinner")

# Called when the node enters the scene tree for the first time.
func _ready():
	var gun_resource= null
	if(gun == 1):
		 gun_resource = load("res://assets/Gun/Gun.tscn")
	elif(gun == 2):
		 gun_resource = load("res://assets/RocketLauncher/RocketLauncher.tscn")
	
	if(gun):
		var gun_instance = gun_resource.instance()
		spinner.add_child(gun_instance)

func _physics_process(delta):
	spinner.rotate_y(0.05)

func _on_GunPickup_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("pickup", {"gun": gun})
		queue_free()

