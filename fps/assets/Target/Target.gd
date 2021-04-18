extends KinematicBody

signal hit

export var health = 100



func _on_Target_hit(data):
	print('target hit')
	health -= data.damage
	if(health < 0):
		queue_free()
