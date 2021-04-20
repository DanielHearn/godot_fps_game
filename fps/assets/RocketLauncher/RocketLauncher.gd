extends Spatial

signal shoot

onready var bullet = preload("res://assets/Rocket/Rocket.tscn")

export var can_shoot = true

func _on_Gun_shoot():
	can_shoot = false
	var bullet_instance = bullet.instance()
	get_tree().get_root().add_child(bullet_instance)
	bullet_instance.transform = $barrel_end.global_transform
	bullet_instance.velocity = -bullet_instance.transform.basis.z * bullet_instance.muzzle_velocity
	$Timer.start()

func _on_Timer_timeout():
	can_shoot = true
