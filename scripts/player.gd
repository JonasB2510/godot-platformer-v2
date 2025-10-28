extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var input_disabled = false
var animation_paused = false

@onready var sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor() and not input_disabled:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player_left", "player_right")
	if direction > 0 and not input_disabled:
		sprite.flip_h = false
	elif direction < 0 and not input_disabled:
		sprite.flip_h = true
	
	if is_on_floor() and not animation_paused:
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	else:
		sprite.play("jump")
	
	if animation_paused:
		sprite.pause()
	
	if input_disabled:
		return
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
