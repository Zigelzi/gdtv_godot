extends Node
class_name GameAudioPlayer

var _hurt: AudioStreamWAV = preload ("res://assets/audio/hurt.wav")
var _jump: AudioStreamWAV = preload ("res://assets/audio/jump.wav")

func _ready():
    disable_music_in_debug()
    
func play_sfx(sfx_name: String) -> void:
    var sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()
    sfx_player.name = "SFX" + sfx_name
    sfx_player.volume_db = -22

    if sfx_name == "hurt":
        sfx_player.stream = _hurt
    elif sfx_name == "jump":
        sfx_player.stream = _jump
    
    add_child(sfx_player)
    sfx_player.play()
    await sfx_player.finished
    sfx_player.queue_free()

func disable_music_in_debug():
    if OS.is_debug_build():
        $MusicPlayer.autoplay = false
        $MusicPlayer.stop()
    else:
        $MusicPlayer.autoplay = true