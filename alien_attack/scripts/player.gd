extends CharacterBody2D

signal damage_taken

const _ROCKET: PackedScene = preload ("res://scenes/rocket.tscn")

@export var _speed: float = 300.0
@export var _rocket_offset: Vector2 = Vector2(75, 0)
@export var _shoot_cooldown: float = 0.5

@onready var _collider_size: Vector2 = $CollisionShape2D.shape.get_rect().size
@onready var _rocket_pool: Node = $RocketPool
@onready var _hit_sfx_player: AudioStreamPlayer2D = $HitSfxPlayer
@onready var _shoot_sfx_player: AudioStreamPlayer2D = $ShootSfxPlayer
@onready var _thruster_particles: GPUParticles2D = $ThrusterParticles

var _is_ready_to_shoot: bool = true

func _process(_delta):
	if Input.is_action_just_pressed("shoot")&&_is_ready_to_shoot:
		_shoot(global_position)

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction:
		velocity.x = direction.x * _speed
		velocity.y = direction.y * _speed
		_thruster_particles.emitting = true
	else:
		velocity = Vector2.ZERO
		_thruster_particles.emitting = false

	# Player is rotated by 90 degrees, so axises are reversed.
	var player_offset: Vector2 = Vector2(_collider_size.y / 2, _collider_size.x / 2)
	global_position = global_position.clamp(player_offset, get_viewport_rect().size - player_offset)

	move_and_slide()

func take_damage() -> void:
	damage_taken.emit()
	if !_hit_sfx_player: return
	_hit_sfx_player.play()

func _shoot(player_position: Vector2) -> void:
	if !_rocket_pool||!_ROCKET: return
	var rocket_instance: Node = _ROCKET.instantiate()
	_rocket_pool.add_child(rocket_instance)
	rocket_instance.global_position = player_position + _rocket_offset
	_start_shooting_cooldown()
	_shoot_sfx_player.play()

func _start_shooting_cooldown() -> void:
	_is_ready_to_shoot = false
	await get_tree().create_timer(_shoot_cooldown).timeout
	_is_ready_to_shoot = true

func die() -> void:
	queue_free()