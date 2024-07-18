extends Node
class_name GameAudioPlayer

var _hurt: AudioStreamWAV = preload ("res://assets/audio/hurt.wav")
var _jump: AudioStreamWAV = preload ("res://assets/audio/jump.wav")

func play_sfx(name: String) -> void:
    var sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
    sfx_player.name = "SFX" + name

    if name == "hurt":
        sfx_player.stream = _hurt
    elif name == "jump":
        sfx_player.stream = _jump
    
    add_child(sfx_player)
    sfx_player.play()
    sfx_player.volume_db = -22
    await sfx_player.finished
    sfx_player.queue_free()
