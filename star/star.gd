extends Area2D
class_name Star

signal collected


func _on_Star_body_entered(body: Node):
	if body is Player:
		if not body.dead:
			emit_signal("collected")
			queue_free()
