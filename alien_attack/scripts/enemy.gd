extends Area2D

@export var _speed: float = 200.0

func _ready():
	$VisibleNotifier.screen_exited.connect(_on_enemy_screen_exited)

func _physics_process(delta):
	global_position.x -= _speed * delta

func _on_enemy_screen_exited():
	_destroy_offscreen()

func _destroy_offscreen() -> void:
	queue_free()

func die():
	queue_free()
