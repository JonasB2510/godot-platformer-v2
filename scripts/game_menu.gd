extends Control

func _on_start_pressed() -> void:
	get_node("/root/GlobalGameManager").unpause()
	get_node("CanvasLayer").visible = false


func _on_option_pressed() -> void:
	#get_node("/root/GlobalGameManager").unpause()
	#hide()
	#get_node("/root/GlobalGameManager").toggle_options()
	pass

func _on_exit_pressed() -> void:
	get_node("/root/GlobalGameManager").unpause()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
