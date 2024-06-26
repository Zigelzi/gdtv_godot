extends Node2D

signal game_ended

@export var _lives: int = 3

@onready var _player: Node2D = $Player
@onready var _enemy_spawner: Node2D = $EnemySpawner
@onready var _hud = $UI/HUD

var _current_score: int = 0

func _ready():
	_player.damage_taken.connect(_on_player_damage_taken)
	_enemy_spawner.enemy_spawned.connect(_on_enemy_spawn)

	_hud.set_score(_current_score)

func _on_player_damage_taken() -> void:
	_lives -= 1
	if _lives <= 0:
		_end_game()

func _end_game() -> void:
	game_ended.emit()
	_player.die()

func _on_enemy_spawn(enemy: Node2D) -> void:
	enemy.died.connect(_on_enemy_death)

func _on_enemy_death(reward_amount: int) -> void:
	_current_score += reward_amount
	_hud.set_score(_current_score)
	