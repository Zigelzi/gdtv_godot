class_name Enemy
extends Area2D

signal player_hit
signal died(reward: int)
signal destroyed

const REWARD_AMOUNT: int = 100

@export var _speed: float = 200.0
@export var _destroyed_sfx: PackedScene

func _ready():
	$".".body_entered.connect(_on_player_body_entered)
	$VisibleNotifier.screen_exited.connect(_on_enemy_screen_exited)

func _physics_process(delta):
	global_position.x -= _speed * delta

func _on_player_body_entered(body: Node2D) -> void:
	if (body.has_method("take_damage")):
		body.take_damage()
	_spawn_destroy_sfx()
	queue_free()

func _on_enemy_screen_exited() -> void:
	destroy()

func die() -> void:
	died.emit(REWARD_AMOUNT)
	_spawn_destroy_sfx()
	queue_free()

func _disable():
	$".".hide()
	$".".monitoring = false

func destroy() -> void:
	destroyed.emit()
	_spawn_destroy_sfx()
	queue_free()

func _spawn_destroy_sfx():
	if !_destroyed_sfx: return
	var root_node = $".".get_node("/root/Game")
	var sfx_instance = _destroyed_sfx.instantiate()
	root_node.add_child(sfx_instance)
