extends Button

@onready var accept_dialog: AcceptDialog = $"../AcceptDialog"

func _ready() -> void:
	load_config()

func load_config():
	var optionsScript = load("res://scripts/options.gd")
	var optionsScriptInstance = optionsScript.new()
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")

	if err != OK:
		config.set_value("volume", "master", 100)
		config.set_value("volume", "music", 100)
		config.set_value("volume", "sfx", 100)

		# Save to disk
		var err2 = config.save("user://settings.cfg")

		if err2 == OK:
			print("Config saved!")
		else:
			print("Error saving config:", err)
		return

	var master_volume = config.get_value("volume", "master", 100)
	optionsScriptInstance.set_bus_volume_percent("Master", master_volume)
	var music_volume = config.get_value("volume", "music", 100)
	optionsScriptInstance.set_bus_volume_percent("Music", music_volume)
	var sfx_volume = config.get_value("volume", "sfx", 100)
	optionsScriptInstance.set_bus_volume_percent("SFX", sfx_volume)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level1.tscn")

func _on_option_pressed() -> void:
	accept_dialog.title = "Information"
	accept_dialog.dialog_text = "To be implemented!"
	#accept_dialog.show()
	get_tree().change_scene_to_file("res://scenes/options.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
