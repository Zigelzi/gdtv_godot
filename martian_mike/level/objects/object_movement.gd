@tool
extends Node

@export_group("Components")
@export var _animation: AnimationPlayer:
    set(new_animation):
        if new_animation != _animation:
            _animation = new_animation
            update_configuration_warnings()

@export var _movement_path: PathFollow2D:
    set(new_movement_path):
        if new_movement_path != _movement_path:
            _movement_path = new_movement_path
            update_configuration_warnings()

@export_group("Movement")
@export var _is_looping: bool = false
@export var _speed_scale: float = 1


func _get_configuration_warnings() -> PackedStringArray:
    var warnings: Array = []

    if _animation == null:
        warnings.append("This node can't play the movement animation. Add AnimationPlayer component.")

    if _movement_path == null:
        warnings.append("This node doesn't have path to follow. Add PathFollow2D component.")
    return warnings


func _ready():
    if _animation == null || _movement_path == null: return
    _movement_path.progress_ratio = 0
    _movement_path.loop = _is_looping
    _animation.speed_scale = _speed_scale
    _animation.play("path/move")
