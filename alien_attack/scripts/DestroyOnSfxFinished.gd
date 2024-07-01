class_name DestroyOnSfxFinished
extends Node

@onready var _sfx_player: AudioStreamPlayer2D = $".".get_parent()

func _ready():
    await _sfx_player.finished
    _sfx_player.queue_free()