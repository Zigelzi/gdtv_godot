extends Node2D

signal game_ended

@export var _lives: int = 3

@onready var _player: Node2D = $Player

func _ready():
	_player.damage_taken.connect(_on_player_damage_taken)

func _on_player_damage_taken():
	if _lives > 0:
		_lives -= 1
	if _lives <= 0:
		_end_game()

func _end_game():
	game_ended.emit()
	print("Game ended")