extends Node2D

@onready var _spawn_positions: Array[Node] = $SpawnPositions.get_children()
@onready var _spawned_enemies: Node = $Enemies

var _enemy: PackedScene = preload ("res://scenes/enemy_1.tscn")

func _ready():
    $SpawnTimer.timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout():
    _spawn_enemy_to_random_spawn_point()

func _spawn_enemy_to_random_spawn_point() -> void:
    var enemy_instance: Node = _enemy.instantiate()
    _spawned_enemies.add_child(enemy_instance)
    enemy_instance.global_position = _spawn_positions.pick_random().global_position