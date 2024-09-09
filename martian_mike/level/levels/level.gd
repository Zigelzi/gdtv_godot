extends Node2D


@export var _player_scene: PackedScene
@export var _next_level: PackedScene
@export var _level_time: float = 20

@onready var _end_point: Area2D = $LevelStartEndPoints/EndPoint
@onready var _start_point: Area2D = $LevelStartEndPoints/StartPoint
@onready var _start_time: int = Time.get_ticks_msec()
@onready var _ui_layer: UiControl = $UILayer


var _elapsed_time: float = 0
var _is_timer_enabled: bool = true

func _ready():
	_end_point.end_reached.connect(_on_player_end_reached)
	_spawn_player()
	_set_level_timer()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

	if _is_timer_enabled:
		_set_level_timer()

func _on_player_end_reached() -> void:
	_is_timer_enabled = false
	if _next_level:
		_ui_layer.set_next_level(_next_level)
		_ui_layer.display_next_level_screen(true)
	else:
		_ui_layer.display_win_screen(true)

func _spawn_player() -> void:
	if !_player_scene: return

	var instantiated_player: Player = _player_scene.instantiate()
	instantiated_player.set_start_position(_start_point.global_position)
	instantiated_player.global_position = _start_point.global_position
	instantiated_player.energy_updated.connect(_ui_layer.on_player_energy_updated)
	instantiated_player.died.connect(_on_player_died)
	add_child(instantiated_player)

func _on_player_died() -> void:
	get_tree().reload_current_scene()

func _set_level_timer() -> void:
	_elapsed_time = Time.get_ticks_msec() - _start_time
	_elapsed_time = float(_elapsed_time) / 1000
	_ui_layer.set_time_label(_elapsed_time)