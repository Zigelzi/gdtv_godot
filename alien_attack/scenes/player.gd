extends CharacterBody2D

@export var horizontal_speed: float = 300.0
@export var vertical_speed:float = 100.0

func _physics_process(_delta):
	var direction = Input.get_axis("move_up", "move_down")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = move_toward(velocity.x, 0, horizontal_speed)

	if direction:
		velocity.y = direction * vertical_speed
	else:
		velocity.y = 0

	move_and_slide()
