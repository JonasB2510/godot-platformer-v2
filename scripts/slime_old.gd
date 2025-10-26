extends Node2D

const SPEED = 60
var direction = 1
var is_dead = false

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone
@onready var kill_enemie: Area2D = $KillEnemie

var velocity = Vector2()

func _physics_process(delta: float) -> void:
	if not is_dead:
		if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
		elif ray_cast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false
		position.x += direction * SPEED * delta
	else:
		position.y += 200 * delta
		print(position.y)

func _on_kill_enemie_body_entered(body: Node2D) -> void:
	is_dead = true
	killzone.monitoring = false
	animated_sprite.play("death")
