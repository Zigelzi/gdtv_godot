extends CanvasLayer

func display_win_screen(is_enabled: bool) -> void:
	$WinScreen.visible = is_enabled

func display_next_level_screen(is_enabled: bool) -> void:
	$NextLevelScreen.visible = is_enabled

func set_next_level(scene: PackedScene) -> void:
	$NextLevelScreen.next_level = scene
