extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size

var PLAYER_WIDTH = 64
var PLAYER_HEIGHT = 64
var sprite_size



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size/2
	var sprite = $Sprite
	sprite_size = sprite.texture.get_size()
	var sprite_scale = Vector2(sprite_size.x/PLAYER_WIDTH, sprite_size.y/PLAYER_HEIGHT)

	sprite.scale = sprite_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _input(event):
	if Input.is_action_just_pressed("ui_right"):
		position += Vector2(PLAYER_WIDTH,0)
	elif Input.is_action_just_pressed("ui_left"):
		position += Vector2(-PLAYER_WIDTH,0)
	elif Input.is_action_just_pressed("ui_up"):
		position += Vector2(0,-PLAYER_HEIGHT)
	elif Input.is_action_just_pressed("ui_down"):
		position += Vector2(0,PLAYER_HEIGHT)
