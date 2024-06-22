extends Area2D

@export var _speed: int = 200

func _ready():
	$VisibleNotifier.screen_exited.connect(_on_rocket_screen_exited)
	$".".area_entered.connect(_on_enemy_area_entered)

func _physics_process(delta):
	global_position.x += _speed * delta

func _on_rocket_screen_exited() -> void:
	_destroy_offscreen()

func _destroy_offscreen() -> void:
	queue_free()

func _on_enemy_area_entered(area: Area2D) -> void:
	if area.has_method("die"):
		area.die()
		queue_free()
