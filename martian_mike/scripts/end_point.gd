extends Area2D

signal end_reached

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
    $".".body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        body.is_active = false
        _animated_sprite.play("pressed")
        end_reached.emit()