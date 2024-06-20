extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	else:
		velocity = Vector2.ZERO

	# clamp_to_viewport(global_position)
	global_position = global_position.clamp(Vector2(0,0), get_viewport_rect().size)

	move_and_slide()

func clamp_to_viewport(player_position: Vector2) -> void:
	print(player_position)
	print(get_viewport_rect().size)
	player_position = player_position.clamp(Vector2(0,0), get_viewport_rect().size)