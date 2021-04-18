extends Area


export var health_boost = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HealthPack_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("pickup", {"health": health_boost})
		queue_free()
