extends CharacterBody2D

@export var speed: float = 300.0

@onready var collider_size: Vector2 = $CollisionShape2D.shape.get_rect().size

func _ready():
	print(collider_size)

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
	else:
		velocity = Vector2.ZERO

	# Player is rotated by 90 degrees, so axises are reversed.
	var player_offset: Vector2 = Vector2(collider_size.y / 2, collider_size.x / 2)
	global_position = global_position.clamp(player_offset, get_viewport_rect().size - player_offset)

	move_and_slide()

func clamp_to_viewport(player_position: Vector2) -> void:
	print(player_position)
	print(get_viewport_rect().size)
	player_position = player_position.clamp(Vector2(0,0), get_viewport_rect().size)