extends Area2D
class_name Stalagtite


func _on_Stalagtite_body_entered(body: Node) -> void:
	if body is Player:
		body.die()
