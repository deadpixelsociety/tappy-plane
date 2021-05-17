extends RigidBody2D
class_name Player

signal died

const TAP_POWER: float = 200.0
const MAX_SPEED: float = 350.0
const TILT_UP_MAX: float = 100.0
const TILT_UP_ANGLE: float = -33.0
const TILT_DOWN_MAX: float = 200.0
const TILT_DOWN_ANGLE: float = 66.0 

var dead: bool = false

onready var _sprite: AnimatedSprite = $AnimatedSprite
onready var _fire: Particles2D = $Fire


func _ready() -> void:
	connect("body_entered", self, "_on_Player_body_entered")


func _physics_process(delta) -> void:
	if linear_velocity.length() >= MAX_SPEED:
		linear_velocity = linear_velocity.normalized() * MAX_SPEED

	var angle = 0.0
	if linear_velocity.y < 0.0:
		var vy = min(TILT_UP_MAX, abs(linear_velocity.y))
		angle = TILT_UP_ANGLE * (vy / TILT_UP_MAX)
	elif linear_velocity.y > 0.0:
		var vy = min(TILT_DOWN_MAX, abs(linear_velocity.y))
		angle = TILT_DOWN_ANGLE * (vy / TILT_DOWN_MAX)

	if angle == 0.0 and dead:
		angle = TILT_DOWN_ANGLE
		
	rotation_degrees = angle


func tap() -> void:
	if dead:
		return
		
	apply_central_impulse(Vector2.UP * TAP_POWER)


func reset() -> void:
	dead = false
	_fire.emitting = false
	_sprite.playing = true
	connect("body_entered", self, "_on_Player_body_entered")

func die() -> void:
	dead = true
	_fire.emitting = true
	_sprite.playing = false
	emit_signal("died")


func _on_Player_body_entered(body: Node):
	if body is Ceiling: 
		return
		
	disconnect("body_entered", self, "_on_Player_body_entered")
	die()
