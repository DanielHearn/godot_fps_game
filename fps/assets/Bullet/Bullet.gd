extends Area

var damage = 25
var muzzle_velocity = 75
var velocity = Vector3.ZERO

onready var hit_particle = preload("res://assets/BulletParticleHit/BulletParticleHit.tscn")

func _physics_process(delta):
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta
 
func _on_Bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	if not body.is_in_group("player"):
		var particle_instance = hit_particle.instance()
		get_tree().get_root().add_child(particle_instance)
		particle_instance.transform = $CollisionShape.global_transform
		particle_instance.translate_object_local(Vector3(0, 0, 10))
		body.emit_signal('hit', {"damage": damage})
		queue_free()


func _on_Timer_timeout():
	queue_free()
