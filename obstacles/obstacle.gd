extends Node2D
class_name Obstacle

signal star_collected

var moving = true

var _visible = false

onready var _visibility: VisibilityNotifier2D = $VisibilityNotifier2D


func _ready() -> void:
	_find_stars()


func _process(delta) -> void:
	if not _visible:
		_check_on_screen()
	else:
		_check_off_screen()
	
	if moving:
		position.x -= 150.0 * delta


func _check_off_screen() -> void:
	if is_instance_valid(_visibility) and not _visibility.is_on_screen():
		queue_free()


func _check_on_screen() -> void:
	if is_instance_valid(_visibility) and _visibility.is_on_screen():
		_visible = true


func _find_stars() -> void:
	for child in get_children():
		if child is Star:
			child.connect("collected", self, "_star_collected")


func _star_collected(body: Node) -> void:
	emit_signal("star_collected")
