extends Area

var damage = 100

func _physics_process(delta):
	pass;
 
func _on_Timer_timeout():
	queue_free()


func _on_Explosion_body_entered(body):
	print(body)
	print(body.is_in_group("enemies"))
	if body.is_in_group("enemies"):
		body.emit_signal("hit", {"damage": damage})
		queue_free()
