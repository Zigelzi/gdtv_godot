extends Path2D

@onready var _movement_path: PathFollow2D = $PathFollow2D
@onready var enemy: Node = $PathFollow2D/Enemy

func _ready():
    _movement_path.progress_ratio = 0

func _process(delta):
    _movement_path.progress_ratio += .25 * delta
    if _movement_path.progress_ratio >= 1:
        queue_free()