extends Node2D

@onready var enemy:PackedScene = preload("res://scenes/enemy_1.tscn")
@onready var spawn_positions:Array[Node] = $SpawnPositions.get_children()
@onready var spawned_enemies:Node = $Enemies

var rng:RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
    $SpawnTimer.timeout.connect(spawn_enemy_to_random_spawn_point)

func spawn_enemy_to_random_spawn_point() -> void:
    var enemy_instance:Node = enemy.instantiate()
    var spawn_position_index:int = rng.randi_range(0, spawn_positions.size()-1)
    spawned_enemies.add_child(enemy_instance)
    enemy_instance.global_position = spawn_positions[spawn_position_index].global_position