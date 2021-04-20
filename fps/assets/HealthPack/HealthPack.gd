extends Area


export var health_boost = 10

func _on_HealthPack_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("pickup", {"health": health_boost})
		queue_free()
