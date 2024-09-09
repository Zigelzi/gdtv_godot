extends CanvasLayer
class_name UiControl

@onready var _hud_time_label: Label = $HUD/TimeLabel
@onready var _hud_energy_label: Label = $HUD/EnergyLabel

func display_win_screen(is_enabled: bool) -> void:
	$WinScreen.visible = is_enabled

func display_next_level_screen(is_enabled: bool) -> void:
	$NextLevelScreen.visible = is_enabled

func set_next_level(scene: PackedScene) -> void:
	$NextLevelScreen.next_level = scene

func set_time_label(new_time: float) -> void:
	if !_hud_time_label: return

	_hud_time_label.text = "TIME: %.1f" % new_time

func on_player_energy_updated(new_energy_amount: float) -> void:
	set_energy_label(new_energy_amount)

func set_energy_label(new_energy: float) -> void:
	if !_hud_time_label: return

	_hud_energy_label.text = "ENERGY: %.0f" % new_energy
