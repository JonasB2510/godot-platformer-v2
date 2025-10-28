extends Control

@onready var master_slider: HSlider = $Panel/VBoxContainer/Master/Master
@onready var music_slider: HSlider = $Panel/VBoxContainer/Music/Music
@onready var sfx_slider: HSlider = $Panel/VBoxContainer/SFX/SFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_config()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		var config = ConfigFile.new()
		config.set_value("volume", "master", master_slider.value)
		config.set_value("volume", "music", music_slider.value)
		config.set_value("volume", "sfx", sfx_slider.value)
		config.save("user://settings.cfg")
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func load_config():
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
	master_slider.set_value_no_signal(master_volume)
	#set_bus_volume_percent("Master", master_volume)
	var music_volume = config.get_value("volume", "music", 100)
	music_slider.set_value_no_signal(music_volume)
	#set_bus_volume_percent("Music", music_volume)
	var sfx_volume = config.get_value("volume", "sfx", 100)
	sfx_slider.set_value_no_signal(sfx_volume)
	#set_bus_volume_percent("SFX", sfx_volume)

func set_bus_volume_percent(bus_name: String, percent: float) -> void:
	percent = clamp(percent, 0.0, 100.0)
	
	# Map 0–100% directly to -80 dB to 0 dB
	var db = lerp(-10.0, 6.0, percent / 100.0)
	if percent == 0:
		db = -80
	
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, db)



func _on_master_value_changed(value: float) -> void:
	set_bus_volume_percent("Master", value)


func _on_music_value_changed(value: float) -> void:
	set_bus_volume_percent("Music", value)


func _on_sfx_value_changed(value: float) -> void:
	set_bus_volume_percent("SFX", value)
