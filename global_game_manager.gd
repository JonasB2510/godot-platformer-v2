extends Node

var playrt: CharacterBody2D
@onready var timer: Timer = $Timer
const MENU_SCENE := preload("res://scenes/game_menu.tscn")
const OPTION_SCENE := preload("res://scenes/options.tscn")
@onready var player: CharacterBody2D# = %Player

var menu_instance: Control
var option_instance: Control

func _ready() -> void:
	timer.wait_time = 1
	timer.start()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("close_ui"):
		if player:
			if not menu_instance:
				menu_instance = MENU_SCENE.instantiate()
				player.add_child(menu_instance)
				menu_instance.scale = Vector2(0.25, 0.25) # 4 times zoom by camera
				menu_instance.show()
			else:
				menu_instance.get_node("CanvasLayer").visible = not menu_instance.get_node("CanvasLayer").visible
			if menu_instance.get_node("CanvasLayer").visible == true:
				Engine.time_scale = 0
				player.input_disabled = true
				player.animation_paused = true
			else:
				unpause()

#func toggle_options():
#	if not option_instance:
#		option_instance = OPTION_SCENE.instantiate()
#		player.add_child(option_instance)
#		option_instance.scale = Vector2(0.25, 0.25)
#		option_instance.show()
#	else:
#		option_instance.visible = not option_instance.visible
	
func unpause():
	Engine.time_scale = 1
	player.input_disabled = false
	player.animation_paused = false

func _on_timer_timeout() -> void:
	if has_node("/root/Game/Player"):
		player = get_node("/root/Game/Player")
	else:
		timer.start()
