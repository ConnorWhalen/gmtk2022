extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size

var PLAYER_WIDTH = 64
var PLAYER_HEIGHT = 64
var sprite_size
var sprite2_size

var roll_progress = 0
var right_roll_flag = false
var left_roll_flag = false
var up_roll_flag = false
var down_roll_flag = false

onready var sprite = $Sprite
onready var sprite2 = $Sprite2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size/2
	sprite_size = sprite.texture.get_size()
	sprite2_size = sprite2.texture.get_size()
	var sprite_scale = Vector2(sprite_size.x/PLAYER_WIDTH, sprite_size.y/PLAYER_HEIGHT)
	var sprite2_scale = Vector2(sprite2_size.x/PLAYER_WIDTH, sprite2_size.y/PLAYER_HEIGHT)

	sprite.scale = sprite_scale
	sprite2.scale = sprite2_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(right_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(true,false,false,false)
		if roll_progress == 1.0:
			right_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	elif(left_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,true,false,false)
		if roll_progress == 1.0:
			left_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	elif(up_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,false,true,false)
		if roll_progress == 1.0:
			up_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	elif(down_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,false,false,true)
		if roll_progress == 1.0:
			down_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	pass

func _input(_event):
	if Input.is_action_just_pressed("ui_right"):
		position += Vector2(PLAYER_WIDTH,0)
		right_roll_flag = true
	elif Input.is_action_just_pressed("ui_left"):
		position += Vector2(-PLAYER_WIDTH,0)
		left_roll_flag = true
	elif Input.is_action_just_pressed("ui_up"):
		position += Vector2(0,-PLAYER_HEIGHT)
		up_roll_flag = true
	elif Input.is_action_just_pressed("ui_down"):
		position += Vector2(0,PLAYER_HEIGHT)
		down_roll_flag = true

func set_shader(bRight=false, bLeft=false, bUp=false, bDown=false):
	sprite.material.set_shader_param("right", bRight)
	sprite2.material.set_shader_param("right", bRight)
	sprite.material.set_shader_param("left", bLeft)
	sprite2.material.set_shader_param("left", bLeft)
	sprite.material.set_shader_param("up", bUp)
	sprite2.material.set_shader_param("up", bUp)
	sprite.material.set_shader_param("down", bDown)
	sprite2.material.set_shader_param("down", bDown)

func set_progress(progress = 0):
	sprite.material.set_shader_param("progress", progress)
	sprite2.material.set_shader_param("progress", progress)
