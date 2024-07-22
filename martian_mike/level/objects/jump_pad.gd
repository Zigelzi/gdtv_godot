extends Area2D

@export var _bounce_force: float = 500.0

@onready var _animation: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	$".".body_entered.connect(_on_player_body_entered)

func _on_player_body_entered(body: Node2D) -> void:
	if body is Player:
		_animation.play("jump")
		body.jump(_bounce_force)
