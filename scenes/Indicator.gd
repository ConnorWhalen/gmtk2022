extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tp = TexturePacks.get_texturepack(TexturePacks.TP_INDEX.DEFAULT_TP)
onready var save_stats = Save.pull_stats()
var texture_arr
onready var sprite = $Sprite

const LERP_SPEED_MULTIPLIER = 0.01
var lerp_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	texture_arr = tp.texture_arr
	sprite.set_scale(Vector2(0.25,0.25))
	lerp_speed = save_stats["stats"][Save.STAT_INDEX.FADE]["count"] * LERP_SPEED_MULTIPLIER
	pass # Replace with function body.

func set_value(value):
	sprite.set_texture(texture_arr[value - 1])
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_modulate(lerp(get_modulate(), Color(1,1,1,1), lerp_speed))

func fade_in():
	if(visible == false):
		set_modulate(0)
		visible = true
