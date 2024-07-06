extends Node2D

signal game_ended

const GAME_OVER_SCREEN: PackedScene = preload ("res://scenes/game_over_screen.tscn")

@export var _lives: int = 3
@export var _difficulty_increase_treshold: int = 500

var _current_score: int = 0

@onready var _player: Node2D = $Player
@onready var _enemy_spawner: EnemySpawner = $EnemySpawner
@onready var _hud = $UI/HUD

func _ready():
	_player.damage_taken.connect(_on_player_damage_taken)
	_enemy_spawner.enemy_spawned.connect(_on_enemy_spawn)

	_hud.set_score(_current_score)
	_hud.set_lives(_lives)

func _on_player_damage_taken() -> void:
	_reduce_lives()

func _reduce_lives() -> void:
	if _lives > 0:
		_lives -= 1
		_hud.set_lives(_lives)
	if _lives == 0:
		_end_game()

func _end_game() -> void:
	game_ended.emit()
	_player.die()
	_spawn_game_over_screen()

func _spawn_game_over_screen() -> void:
	var game_over_screen_instance: Node = GAME_OVER_SCREEN.instantiate()
	game_over_screen_instance.set_score(_current_score)
	$UI.add_child(game_over_screen_instance)

func _on_enemy_spawn(enemy: Enemy) -> void:
	enemy.died.connect(_on_enemy_death)
	enemy.destroyed.connect(_on_enemy_destroyed)

func _on_enemy_death(reward_amount: int) -> void:
	_current_score += reward_amount
	_hud.set_score(_current_score)
	if _current_score % _difficulty_increase_treshold == 0:
		_enemy_spawner.reduce_spawn_time()

func _on_enemy_destroyed():
	_reduce_lives()
