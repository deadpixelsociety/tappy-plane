extends Area2D
class_name Stalagmite


func _on_Stalagmite_body_entered(body: Node) -> void:
	if body is Player:
		body.die()
