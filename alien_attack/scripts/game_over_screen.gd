extends Control

@onready var _play_again_button: Button = $PanelContainer/MarginContainer/VBoxContainer/PlayAgainButton

func _ready():
	_play_again_button.pressed.connect(_on_play_again_button_pressed)

func _on_play_again_button_pressed() -> void:
	get_tree().reload_current_scene()

func set_score(new_score: int) -> void:
	var score_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreContainer/ScoreLabel
	if !score_label: return
	score_label.text = "Score: " + str(new_score)