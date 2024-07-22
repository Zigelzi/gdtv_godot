extends CanvasLayer
class_name UiControl

@onready var _hud_time_label: Label = $HUD/TimeLabel

func display_win_screen(is_enabled: bool) -> void:
	$WinScreen.visible = is_enabled

func display_next_level_screen(is_enabled: bool) -> void:
	$NextLevelScreen.visible = is_enabled

func set_next_level(scene: PackedScene) -> void:
	$NextLevelScreen.next_level = scene

func set_time_label(new_time: float) -> void:
	if !_hud_time_label: return

	_hud_time_label.text = "TIME: %.0f" % new_time