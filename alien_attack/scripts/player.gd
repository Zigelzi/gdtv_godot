extends CharacterBody2D

@export var speed: float = 300.0
@export var rocket_offset: Vector2 = Vector2(75,0)

@onready var collider_size: Vector2 = $CollisionShape2D.shape.get_rect().size
@onready var rocket_pool:Node = $RocketPool

const rocket = preload("res://scenes/rocket.tscn")

func _process(_delta):	
	if Input.is_action_just_pressed("shoot"):
		shoot(global_position)


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

func shoot(player_position: Vector2) -> void:
	if !rocket_pool || !rocket: return
	var rocket_instance = rocket.instantiate()
	rocket_pool.add_child(rocket_instance)
	rocket_instance.global_position = player_position + rocket_offset
