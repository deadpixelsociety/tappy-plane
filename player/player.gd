extends RigidBody2D
class_name Player

const TAP_POWER: float = 400.0
const MAX_SPEED: float = 350.0
const TILT_UP_MAX: float = 100.0
const TILT_UP_ANGLE: float = -33.0
const TILT_DOWN_MAX: float = 200.0
const TILT_DOWN_ANGLE: float = 66.0 

onready var _sprite: AnimatedSprite = $AnimatedSprite

func _physics_process(delta) -> void:
	if linear_velocity.length() >= MAX_SPEED:
		linear_velocity = linear_velocity.normalized() * MAX_SPEED
		
	if Input.is_action_just_pressed("tap"):
		tap()

	var angle = 0.0
	if linear_velocity.y < 0.0:
		var vy = min(TILT_UP_MAX, abs(linear_velocity.y))
		angle = TILT_UP_ANGLE * (vy / TILT_UP_MAX)
	elif linear_velocity.y > 0.0:
		var vy = min(TILT_DOWN_MAX, abs(linear_velocity.y))
		angle = TILT_DOWN_ANGLE * (vy / TILT_DOWN_MAX)

	rotation_degrees = angle


func tap() -> void:
	apply_central_impulse(Vector2.UP * TAP_POWER)
