extends Area2D

@export var _bounce_force: float = 20.0

func _ready():
	$".".body_entered.connect(_on_player_body_entered)

func _on_player_body_entered(body: Node2D) -> void:
	body.velocity.y = -_bounce_force
