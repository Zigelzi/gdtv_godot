extends Node2D

@onready var _area2d: Area2D = $Area2D

func _ready():
    _area2d.body_entered.connect(_on_player_body_entered)

func _on_player_body_entered(body: Node2D) -> void:
    if body is Player:
        body.reset()