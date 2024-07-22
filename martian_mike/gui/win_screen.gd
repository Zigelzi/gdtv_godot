extends Control

func _ready():
    $Content/ButtonContainer/VBoxContainer/RetryButton.pressed.connect(_on_retry_button_pressed)
    $Content/ButtonContainer/VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)

func _on_retry_button_pressed() -> void:
    get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
    get_tree().quit()