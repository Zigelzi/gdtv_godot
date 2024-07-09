extends Node2D

@onready var death_zone: Area2D = $DeathZone

func _ready():
	death_zone.body_entered.connect(_on_player_body_entered)

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_body_entered(body: Node2D) -> void:
	if body is Player:
		body.reset()
