extends Control

signal initialise_player_gui

onready var health_text = $"status/health_label"
var player_instance = null

func initialise_player_gui(player):
	player_instance = player
	health_text.text = String(player_instance.health)

func update_status(status):
	health_text.text = String(status["health"])

func _on_Player_status_change(status):
	update_status(status)

func _on_GUI_initialise_player_gui(player):
	initialise_player_gui(player)
