extends Sprite
class_name Background

onready var _animation_player: AnimationPlayer = $AnimationPlayer

func start() -> void:
	stop()
	_animation_player.play("scroll")


func pause() -> void:
	_animation_player.stop(false)

func stop() -> void:
	_animation_player.stop(true)
