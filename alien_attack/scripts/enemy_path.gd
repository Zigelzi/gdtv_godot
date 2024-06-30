extends Path2D

@export var _speed: float = 0.25

@onready var _movement_path: PathFollow2D = $PathFollow2D
@onready var enemy: Node = $PathFollow2D/Enemy

func _ready():
    _movement_path.progress_ratio = 0

func _process(delta):
    _movement_path.progress_ratio += _speed * delta
    if _movement_path.progress_ratio >= 1:
        queue_free()