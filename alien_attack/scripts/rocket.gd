extends Area2D

@export var speed: int = 200

func _ready():
	$VisibleNotifier.screen_exited.connect(_destroy_offscreen)

func _physics_process(delta):
	global_position.x += speed * delta


func _destroy_offscreen():
	queue_free()
