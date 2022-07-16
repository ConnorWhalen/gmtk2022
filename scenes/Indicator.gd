extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tp = TexturePacks.get_texturepack(TexturePacks.TP_INDEX.DEFAULT_TP)
var texture_arr
onready var sprite = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	texture_arr = tp.texture_arr
	sprite.set_scale(Vector2(0.25,0.25))
	pass # Replace with function body.

func set_value(value):
	sprite.set_texture(texture_arr[value - 1])
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
