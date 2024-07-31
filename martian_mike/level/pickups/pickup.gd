class_name Pickup
extends Area2D

@export var _energy_amount: float = 30.0

func _ready():
	$".".body_entered.connect(_on_player_body_entered)

func _on_player_body_entered(body: Node2D) -> void:
	if body is Player:
		body.grant_energy(_energy_amount)
		queue_free()
