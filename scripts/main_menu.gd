extends Button

@onready var accept_dialog: AcceptDialog = $"../AcceptDialog"

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level2.tscn")

func _on_option_pressed() -> void:
	accept_dialog.title = "Information"
	accept_dialog.dialog_text = "To be implemented!"
	#accept_dialog.show()
	get_tree().change_scene_to_file("res://scenes/options.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
