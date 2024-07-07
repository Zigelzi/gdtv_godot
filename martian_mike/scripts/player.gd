extends CharacterBody2D

@export var _speed: int = 200
@export var _jump_force: float = 600
@export var _max_fall_velocity: float = 400

@onready var _animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var _default_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var direction: float = _get_movement_input()
	_get_jump_input()
	
	if !is_on_floor():
		velocity.y += _default_gravity * delta
		if velocity.y >= _max_fall_velocity:
			velocity.y = _max_fall_velocity

	if direction != 0:
		_animations.flip_h = direction == - 1

	_update_animations(direction)
	move_and_slide()

func _get_movement_input() -> float:
	var input: float = Input.get_axis("move_left", "move_right")
	velocity.x = input * _speed
	return input

func _get_jump_input() -> void:
	if Input.is_action_just_pressed("jump")&&is_on_floor():
		velocity.y = -_jump_force

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