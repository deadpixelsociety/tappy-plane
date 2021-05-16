extends Node2D

onready var _background: Background = $Background
onready var _ground: Ground = $Ground
onready var _ceiling: Ceiling = $Ceiling

func _ready():
	_background.start()
	_ceiling.start()
	_ground.start()
