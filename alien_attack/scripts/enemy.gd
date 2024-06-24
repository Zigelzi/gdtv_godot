extends Area2D

signal player_hit

@export var _speed: float = 200.0

func _ready():
	$VisibleNotifier.screen_exited.connect(_on_enemy_screen_exited)
	$".".body_entered.connect(_on_player_body_entered)

func _physics_process(delta):
	global_position.x -= _speed * delta

func _on_enemy_screen_exited():
	_destroy_offscreen()

func _destroy_offscreen() -> void:
	queue_free()

func _on_player_body_entered(body: Node2D):
	if (body.has_method("take_damage")):
		body.take_damage()
	die()

func die():
	queue_free()
