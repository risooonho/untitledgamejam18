extends KinematicBody2D

# m^2
export var wing_area: float = 20.0
# kg
export var plane_mass: float = 100.0

export var lift_coefficient: float  = 1.0
export var drag_coefficient: float  = 1.0
export var air_density: float  = 1.0
export var initial_velocity: Vector2 = Vector2(20.0, 0.0)
export var initial_angle: float = -5.0
export var gravity: float = 9.81

# Velocity in m/s
var _velocity: Vector2 = Vector2.ZERO
# earths gravity in m/s


# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = deg2rad(initial_angle)
	_velocity = initial_velocity

func _physics_process(delta):
#	print(_velocity)
	var _lift_amplitude = 0.5 * lift_coefficient * air_density * _velocity.x * _velocity.x * wing_area
	var _drag_amplitude = 0.5 * drag_coefficient * air_density * _velocity.x * _velocity.x * wing_area
	var _weight_force = plane_mass * gravity

	var _force = Vector2(
		_lift_amplitude * sin(rotation) - _drag_amplitude * cos(rotation),
		-(_lift_amplitude * cos(rotation) + _drag_amplitude * sin(rotation) - _weight_force)
	)
#	print(_lift_amplitude)

	var _acceleration = _force / plane_mass

	_velocity += _acceleration * delta

	move_and_collide(_velocity * delta)
	# var _lift_force = Vector3(sin(_body.rotation.z), 0.0, 0.0) * _lift_amplitude
	# var _drag_force = Vector3(0.0 ,cos(_body.rotation.z), 0.0) * _lift_amplitude

	# var _wing_loading: float = plane_weight / wing_area

	# _velocity.x = sqrt(2.0 * gravity * _wing_loading / air_density * lift_coefficient)
	# _body.move_and_collide(_velocity)