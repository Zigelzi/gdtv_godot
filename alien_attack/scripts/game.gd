extends Node2D

signal game_ended

@export var _lives: int = 3

@onready var _player: Node2D = $Player
@onready var _enemy_spawner: Node2D = $EnemySpawner

var _current_score: int = 0

func _ready():
	_player.damage_taken.connect(_on_player_damage_taken)
	_enemy_spawner.enemy_spawned.connect(_on_enemy_spawn)

func _on_player_damage_taken():
	if _lives > 0:
		_lives -= 1
	if _lives <= 0:
		_end_game()

func _end_game():
	game_ended.emit()
	print("Game ended")

func _on_enemy_spawn(enemy: Node2D):
	enemy.died.connect(_on_enemy_death)

func _on_enemy_death(reward_amount: int):
	_current_score += reward_amount
	print(_current_score)