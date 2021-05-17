extends Node2D

var _obstacle_pool = [
	preload("res://obstacles/obstacle1.tscn")
]

onready var _background: Background = $Background
onready var _ground: Ground = $Ground
onready var _ceiling: Ceiling = $Ceiling
onready var _tap_button := $UI/TapButton
onready var _player: Player = $Player
onready var _obstacles := $Obstacles
onready var _obstacle_spawn: Node2D = $ObstacleSpawn
onready var _obstacle_timer: Timer = $ObstacleTimer


func _ready():
	_scroll(true)	
	_tap_button.disabled = false
	_obstacle_timer.start()


func _tap() -> void:
	_player.tap()


func _spawn_obstacle() -> void:
	_obstacle_pool.shuffle()
	
	var obstacle = (_obstacle_pool.front() as PackedScene).instance()
	if obstacle is Node2D:
		obstacle.global_position = _obstacle_spawn.global_position
		_obstacles.add_child(obstacle)


func _scroll(scrolling: bool) -> void:
	if scrolling:
		_background.start()
		_ceiling.start()
		_ground.start()
	else:
		_background.pause()
		_ceiling.pause()
		_ground.pause()


func _on_Player_died():
	_obstacle_timer.stop()
	_scroll(false)
	_tap_button.disabled = true

	for obstacle in get_tree().get_nodes_in_group("obstacles"):
		if obstacle is Obstacle:
			obstacle.moving = false


func _on_ObstacleTimer_timeout():
	_spawn_obstacle()
