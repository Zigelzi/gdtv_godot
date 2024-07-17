extends Control

var _next_level: PackedScene

func _ready():
    $Content/ButtonContainer/VBoxContainer/NextLevelButton.pressed.connect(_on_next_level_button_pressed)
    $Content/ButtonContainer/VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)

func _on_next_level_button_pressed() -> void:
    if !_next_level: return
    get_tree().change_scene_to_packed(_next_level)

func _on_quit_button_pressed() -> void:
    get_tree().quit()