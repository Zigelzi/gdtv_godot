class_name EnemySpawner
extends Node2D

signal enemy_spawned(new_enemy: Enemy)

@export var _enemy_types: Array[PackedScene]
@export var _initial_spawn_time: float = 3.0
@export var _spawn_time_reduction_step: float = 0.5

@onready var _root_node: Node2D = $".".get_node("/root/Game") as Node2D
@onready var _spawned_enemies: Node = $Enemies
@onready var _spawn_positions: Array[Node] = $SpawnPositions.get_children()
@onready var _spawn_timer: Timer = $SpawnTimer

var _current_spawn_time: float

func _ready():
	_spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	_root_node.game_ended.connect(_on_game_ended)

	_current_spawn_time = _initial_spawn_time
	_spawn_timer.wait_time = _current_spawn_time

func _on_spawn_timer_timeout() -> void:
	_spawn_enemy_to_random_spawn_point()

func _spawn_enemy_to_random_spawn_point() -> void:
	if _enemy_types.is_empty(): return

	var enemy_instance: Node = _enemy_types.pick_random().instantiate()
	_spawned_enemies.add_child(enemy_instance)
	
	if enemy_instance.is_class("Path2D"):
		enemy_spawned.emit(enemy_instance.enemy)
		var spawn_position_index = randi_range(0, _spawn_positions.size() - 3)
		enemy_instance.global_position = _spawn_positions[spawn_position_index].global_position
	if enemy_instance.is_class("Area2D"):
		enemy_spawned.emit(enemy_instance)
		enemy_instance.global_position = _spawn_positions.pick_random().global_position

func _on_game_ended() -> void:
	_spawn_timer.stop()

func reduce_spawn_time() -> void:
	_current_spawn_time = maxf(1, _current_spawn_time - _spawn_time_reduction_step)
	print(_current_spawn_time)
	_spawn_timer.wait_time = _current_spawn_time