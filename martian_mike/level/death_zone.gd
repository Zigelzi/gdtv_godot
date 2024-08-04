class_name DeathZone
extends Area2D

func _ready():
    $".".body_entered.connect(_on_death_zone_body_entered)

func _on_death_zone_body_entered(body: Node2D) -> void:
    if body is Player:
        body.die()