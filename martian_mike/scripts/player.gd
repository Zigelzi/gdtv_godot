extends CharacterBody2D

@export var speed: int = 200

@onready var default_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
    if !is_on_floor():
        velocity.y += default_gravity * delta
    
    move_and_slide()
