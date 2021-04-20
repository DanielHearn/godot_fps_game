extends Area

var damage = 100
var muzzle_velocity = 40
var velocity = Vector3.ZERO

onready var explosion = preload("res://assets/Explosion/Explosion.tscn")

func _physics_process(delta):
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta
 
func _on_Bullet_body_shape_entered(body_id, body, body_shape, area_shape):
	var explosion_instance = explosion.instance()
	get_tree().get_root().add_child(explosion_instance)
	explosion_instance.transform = $CollisionShape.global_transform
	explosion_instance.damage = damage
	explosion_instance.scale.x = 4
	explosion_instance.scale.y = 4
	explosion_instance.scale.z = 4
	queue_free()


func _on_Timer_timeout():
	queue_free()
