extends CharacterBody2D

const SPEED = 60
var direction = 1
var is_dead = false
#const JUMP_VELOCITY = -400.0
const JUMP_VELOCITY = -100.0

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone
@onready var kill_enemie: Area2D = $KillEnemie
@onready var hitbox: CollisionShape2D = $Hitbox
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var player: CharacterBody2D = %Player
@onready var game_manager: Node = %GameManager

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if ray_cast_right.is_colliding():
		var action = ray_cast_right.get_collider().get_meta("action", "hitbox")
		if action == "hitbox":
			direction = -1
		elif action == "jump":
			velocity.y = JUMP_VELOCITY
		
	elif ray_cast_left.is_colliding():
		var action = ray_cast_left.get_collider().get_meta("action", "hitbox")
		if action == "hitbox":
			direction = 1
		elif action == "jump":
			velocity.y = JUMP_VELOCITY
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#direction = 0
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_kill_enemie_body_entered(_body: Node2D) -> void:
	killzone.queue_free()
	kill_enemie.queue_free()
	game_manager.add_point()
	animated_sprite.play("death")
	timer.wait_time = 0.02
	audio_stream_player_2d.play()
	player.jump()
	timer.start()

func _on_timer_timeout() -> void:
	if scale.x > 0.1:
		scale = Vector2(scale.x - 0.1, scale.y - 0.1)
		timer.start()
	else:
		timer.queue_free()
		queue_free()
	
