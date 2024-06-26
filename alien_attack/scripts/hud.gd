extends Control

@onready var _score_label: Label = $Score

func set_score(new_score: int) -> void:
	_score_label.text = "SCORE: " + str(new_score)