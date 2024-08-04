extends Node2D


@export var _player_scene: PackedScene
@export var _next_level: PackedScene
@export var _level_time: float = 20

@onready var _end_point: Area2D = $LevelStartEndPoints/EndPoint
@onready var _start_point: Area2D = $LevelStartEndPoints/StartPoint
@onready var _ui_layer: UiControl = $UILayer

var _level_timer: Timer

func _ready():
	_end_point.end_reached.connect(_on_player_end_reached)
	_spawn_player()
	
	# Level timer disabled. Consuming all energy is the fail condition.
	# spawn_level_timer()

	# _ui_layer.set_time_label(_level_timer.time_left)

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

	# _ui_layer.set_time_label(_level_timer.time_left)

func _on_player_end_reached() -> void:
	# _level_timer.paused = true
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

func spawn_level_timer() -> void:
	_level_timer = Timer.new()
	_level_timer.wait_time = _level_time
	_level_timer.one_shot = true
	add_child(_level_timer)
	_level_timer.start()
	await _level_timer.timeout
	get_tree().reload_current_scene()
