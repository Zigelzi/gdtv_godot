extends Area2D

@export var _speed: int = 200

func _ready():
	$VisibleNotifier.screen_exited.connect(_on_rocket_screen_exited)

func _physics_process(delta):
	global_position.x += _speed * delta

func _on_rocket_screen_exited():
	_destroy_offscreen()

func _destroy_offscreen():
	queue_free()
