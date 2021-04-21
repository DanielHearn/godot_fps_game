extends Spatial

signal reset 

var gui

func _ready():
	gui = get_node("GUI")
	gui.emit_signal("initialise_player_gui", get_node("Player"))


func _on_Main_reset():
	get_tree().reload_current_scene()
