extends Node2D

@export var _player_scene: PackedScene
@export var _next_level: PackedScene

@onready var _death_zone: Area2D = $DeathZone
@onready var _end_point: Area2D = $LevelStartEndPoints/EndPoint
@onready var _start_point: Area2D = $LevelStartEndPoints/StartPoint
@onready var _ui_layer: CanvasLayer = $UILayer

func _ready():
	_death_zone.body_entered.connect(_on_player_body_entered)
	_end_point.end_reached.connect(_on_player_end_reached)
	_spawn_player()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_body_entered(body: Node2D) -> void:
	if body is Player:
		body.reset()
	
func _on_player_end_reached() -> void:
	if _next_level:
		get_tree().change_scene_to_packed(_next_level)
	else:
		_ui_layer.display_win_screen(true)

func _spawn_player() -> void:
	if !_player_scene: return

	var instantiated_player: Player = _player_scene.instantiate()
	instantiated_player.set_start_position(_start_point.global_position)
	instantiated_player.global_position = _start_point.global_position
	add_child(instantiated_player)
