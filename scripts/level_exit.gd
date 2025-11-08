extends Area2D

@export var nextLevel: String

func _on_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file(nextLevel)
