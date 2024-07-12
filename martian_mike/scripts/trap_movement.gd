extends Node2D

@export var _is_movable: bool = false
@export var _is_looping: bool = false
@export var _speed_scale: float = 1

@onready var _movement_path: PathFollow2D = $PathFollow2D
@onready var _animation: AnimationPlayer = $AnimationPlayer

func _ready():
    if !_is_movable: return
    _movement_path.progress_ratio = 0
    _movement_path.loop = _is_looping
    _animation.speed_scale = _speed_scale
    _animation.play("move")
