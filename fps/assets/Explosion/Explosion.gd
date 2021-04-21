extends Area

var damage = 100
 
func _on_Timer_timeout():
	queue_free()

func _on_Explosion_body_entered(body):
	if body.is_in_group("enemies"):
		body.emit_signal("hit", {"damage": damage})
		queue_free()
