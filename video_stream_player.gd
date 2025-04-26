extends VideoStreamPlayer

@onready var video_player = get_node("/root/mainmenu/VideoStreamPlayer")


var video_length := 5

func _ready():
	video_player.play()


func _process(_delta):
	if video_player.stream_position >= video_length:
		video_player.paused = true
