extends Area

export var damage = 25
export var muzzle_velocity = 60
var velocity = Vector3.ZERO

onready var hit_particle = preload("res://assets/BulletParticleHit/BulletParticleHit.tscn")
onready var hit_particle_blood = preload("res://assets/BulletParticleBlood/BulletParticleBlood.tscn")

func _physics_process(delta):
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta
 
func _on_Bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	var particle_instance = null
	if body.is_in_group("enemies") or body.is_in_group("player"):
		body.emit_signal('hit', {"damage": damage})
		particle_instance = hit_particle_blood.instance()
	else:
		particle_instance = hit_particle.instance()
	get_tree().get_root().add_child(particle_instance)
	particle_instance.transform = $CollisionShape.global_transform
	particle_instance.translate_object_local(Vector3(0, 0, 10))

	queue_free()


func _on_Timer_timeout():
	queue_free()
