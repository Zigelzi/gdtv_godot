extends CharacterBody2D
class_name Player

signal energy_updated(new_energy: float)
signal died

@export_subgroup("Movement")
@export var _max_movement_speed: int = 200
@export var _max_acceleration: float = 60.0

@export_subgroup("Energy")
@export var _max_energy: float = 100
@export var _walking_energy_consumption: float = 5.0
@export var _jump_energy_consumption: float = 5.0

@export_subgroup("Jumping")
@export var _max_fall_velocity: float = 600
@export var _jump_height: float = 68
@export var _jump_distance_to_peak: float = 40.0 # px
@export var _jump_distance_to_descent: float = 40.0 # px

@onready var _animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var _hazard_detection: Area2D = $HazardDetection
@onready var _jump_velocity: float = ((2.0 * _jump_height * _max_movement_speed) / _jump_distance_to_peak) * -1.0
@onready var _jump_gravity: float = ((-2.0 * _jump_height * (_max_movement_speed * _max_movement_speed)) / (_jump_distance_to_peak * _jump_distance_to_peak)) * -1.0
@onready var _fall_gravity: float = ((-2.0 * _jump_height * (_max_movement_speed * _max_movement_speed)) / (_jump_distance_to_descent * _jump_distance_to_descent)) * -1.0

var _current_energy: float = -1.0
var start_position: Vector2 = Vector2.ZERO
var _is_active: bool = true
var _is_facing_left: bool = false
var _direction: int = 0

# DEBUG & PROTOTYPING

var _db_is_jumping: bool = false
var _db_is_falling: bool = false
var _db_start_pos: Vector2 = Vector2.ZERO

func _ready():
	_hazard_detection.body_entered.connect(_on_hazard_body_entered)

	_current_energy = _max_energy
	energy_updated.emit(_current_energy)

func _process(_delta):
	if _is_active:
		_direction = _get_movement_input()

	if _direction != 0:
		_is_facing_left = _direction == -1
		_animations.flip_h = _is_facing_left

func _physics_process(delta):
	
	if _is_active:
		_get_jump_input()
		_get_drop_down_input()
		_move(delta)
	else:
		velocity.x = 0
	
	if !is_on_floor():
		velocity.y += _get_gravity() * delta

	if velocity.y >= _max_fall_velocity:
		velocity.y = _max_fall_velocity

	if _direction != 0 && is_on_floor():
		_current_energy -= _walking_energy_consumption * delta
		energy_updated.emit(_current_energy)

	if _current_energy <= 0:
		_current_energy = 0
		energy_updated.emit(_current_energy)
		die()

	if velocity.y > 0:
		_db_is_falling = true
	else:
		_db_is_falling = false
		
	debug_print_jump_distance()
	_update_animations(_direction)
	move_and_slide()

func _on_hazard_body_entered(_body: Node2D) -> void:
	die()

func _get_movement_input() -> int:
	var input: float = Input.get_axis("move_left", "move_right")
	
	return int(input)

func _get_drop_down_input() -> void:
	if Input.is_action_pressed("duck") && Input.is_action_just_pressed("jump") && is_on_floor():
		position.y += 1

func _move(delta: float) -> void:
	var desired_velocity = _direction * _max_movement_speed
	var max_speed_change = _max_acceleration * delta
	velocity.x = move_toward(velocity.x, desired_velocity, max_speed_change)

func die() -> void:
	velocity = Vector2.ZERO
	AudioPlayer.play_sfx("hurt")
	died.emit()

func disable() -> void:
	_is_active = false
	_direction = 0

#region Jumping

func _get_jump_input() -> void:
	if Input.is_action_pressed("duck"): return
	if Input.is_action_just_pressed("jump") && is_on_floor():
		_jump()

func _jump() -> void:
	velocity.y = _jump_velocity
	_current_energy -= _jump_energy_consumption
	energy_updated.emit(_current_energy)
	AudioPlayer.play_sfx("jump")

	_db_is_jumping = true
	_db_start_pos = global_position

func _get_gravity() -> float:
	return _jump_gravity if velocity.y < 0 else _fall_gravity

func debug_print_jump_distance():
	if _db_is_jumping && is_on_floor() && _db_is_falling:
		var jump_distance: float = abs(_db_start_pos.x - global_position.x)
		print(jump_distance)
		_db_is_jumping = false

#endregion

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

#region Energy
func grant_energy(amount: float) -> void:
	_current_energy = minf(_max_energy, _current_energy + amount)
	energy_updated.emit(_current_energy)
#endregion