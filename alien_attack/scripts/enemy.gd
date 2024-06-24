extends Area2D

signal player_hit

@export var _speed: float = 200.0

func _ready():
	$".".body_entered.connect(_on_player_body_entered)
	$VisibleNotifier.screen_exited.connect(_on_enemy_screen_exited)

func _physics_process(delta):
	global_position.x -= _speed * delta

func _on_player_body_entered(body: Node2D):
	if (body.has_method("take_damage")):
		body.take_damage()
	die()

func _on_enemy_screen_exited():
	die()

func die() -> void:
	queue_free()
