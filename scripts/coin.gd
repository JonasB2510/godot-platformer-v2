extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound

func _on_body_entered(_body):
	game_manager.add_point()
	animation_player.play("pickup")
	
func pitch_sound():
	var rng = RandomNumberGenerator.new()
	var pitch_scale = rng.randf_range(0.80, 1.20)
	pickup_sound.pitch_scale = pitch_scale
