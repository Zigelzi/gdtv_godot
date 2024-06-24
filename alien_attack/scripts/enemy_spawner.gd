extends Node2D

@onready var _root_node: Node2D = $".".get_node("/root/Game") as Node2D
@onready var _spawned_enemies: Node = $Enemies
@onready var _spawn_positions: Array[Node] = $SpawnPositions.get_children()
@onready var _spawn_timer: Timer = $SpawnTimer

var _enemy: PackedScene = preload ("res://scenes/enemy_1.tscn")

func _ready():
	_spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	_root_node.game_ended.connect(_on_game_ended)

func _on_spawn_timer_timeout():
	_spawn_enemy_to_random_spawn_point()

func _spawn_enemy_to_random_spawn_point() -> void:
	var enemy_instance: Node = _enemy.instantiate()
	_spawned_enemies.add_child(enemy_instance)
	enemy_instance.global_position = _spawn_positions.pick_random().global_position

func _on_game_ended():
	_spawn_timer.stop()
