extends Control

func set_score(new_score: int) -> void:
    var score_label: Label = $PanelContainer/MarginContainer/ScoreContainer/ScoreLabel
    score_label.text = "Score: " + str(new_score)