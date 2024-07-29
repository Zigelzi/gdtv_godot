extends CharacterBody2D
class_name Player

signal energy_consumed(new_energy: float)
@export var _speed: int = 200

@export_subgroup("Jumping")
@export var _max_fall_velocity: float = 600
@export var _jump_height: float = 68
@export var _jump_distance_to_peak: float = 40.0 # px
@export var _jump_distance_to_descent: float = 40.0 # px

@export_subgroup("Energy")
@export var _max_energy: float = 100
@export var _walking_energy_consumption: float = 5.0

@onready var _animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var _jump_velocity: float = ((2.0 * _jump_height * _speed) / _jump_distance_to_peak) * -1.0
@onready var _jump_gravity: float = ((-2.0 * _jump_height * (_speed * _speed)) / (_jump_distance_to_peak * _jump_distance_to_peak)) * -1.0
@onready var _fall_gravity: float = ((-2.0 * _jump_height * (_speed * _speed)) / (_jump_distance_to_descent * _jump_distance_to_descent)) * -1.0

var _current_energy: float = -1.0
var start_position: Vector2 = Vector2.ZERO
var is_active: bool = true

func _ready():
	_current_energy = _max_energy
	energy_consumed.emit(_current_energy)

func _physics_process(delta):
	var direction: float = 0
	if is_active:
		direction = _get_movement_input()
		velocity.x = direction * _speed
		_get_jump_input()
	else:
		velocity.x = 0
	
	if !is_on_floor():
		velocity.y += _get_gravity() * delta

	if velocity.y >= _max_fall_velocity:
		velocity.y = _max_fall_velocity

	if direction != 0:
		_animations.flip_h = direction == -1
		_current_energy -= _walking_energy_consumption * delta
		energy_consumed.emit(_current_energy)
	
	if _current_energy <= 0:
		reset()

	_update_animations(direction)
	move_and_slide()

func _get_movement_input() -> float:
	var input: float = Input.get_axis("move_left", "move_right")
	
	return input

func _get_jump_input() -> void:
	if Input.is_action_just_pressed("jump") && is_on_floor():
		_jump()

func _jump() -> void:
	velocity.y = _jump_velocity
	AudioPlayer.play_sfx("jump")

func _get_gravity() -> float:
	return _jump_gravity if velocity.y < 0 else _fall_gravity

func _update_animations(direction: float) -> void:
	if is_on_floor():
		if direction == 0:
			_animations.play("idle")
		else:
			_animations.play("run")
	else:
		if velocity.y > 0:
			_animations.play("fall")
		else:
			_animations.play("jump")

func set_start_position(new_position: Vector2) -> void:
	start_position = new_position

func bounce(force: float) -> void:
	velocity.y = -force
	AudioPlayer.play_sfx("jump")

func reset() -> void:
	is_active = true
	global_position = start_position
	velocity = Vector2.ZERO
	AudioPlayer.play_sfx("hurt")
