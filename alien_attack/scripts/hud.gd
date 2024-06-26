extends Control

@onready var _score_label: Label = $Score
@onready var _lives_label: Label = $Lives/Amount

func set_score(new_score: int) -> void:
	_score_label.text = "SCORE: " + str(new_score)

func set_lives(new_lives: int) -> void:
	_lives_label.text = str(new_lives)