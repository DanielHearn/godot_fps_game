extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var health_text = $"status/health_label"

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_health = $"../Player".health
	health_text.text = String(player_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_status(status):
	health_text.text = String(status["health"])

func _on_Player_status_change(status):
	update_status(status)
	pass # Replace with function body.
