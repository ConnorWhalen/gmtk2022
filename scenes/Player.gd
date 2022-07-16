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

enum {DIR_RIGHT, DIR_LEFT, DIR_UP, DIR_DOWN}

var die_face = {"top": 1, "up": 5, "down": 2, "right": 4, "left": 3, "bot": 6}

onready var sprite = $Sprite
onready var sprite2 = $Sprite2

# var one_texture =	preload("res://assets/test_die/icon_1.png")
# var two_texture =	preload("res://assets/test_die/icon_2.png")
# var three_texture =	preload("res://assets/test_die/icon_3.png")
# var four_texture =	preload("res://assets/test_die/icon_4.png")
# var five_texture =	preload("res://assets/test_die/icon_5.png")
# var six_texture =	preload("res://assets/test_die/icon_6.png")
#
# var one_vflip =		preload("res://assets/test_die/icon_1_vflip.png")
# var two_vflip =		preload("res://assets/test_die/icon_2_vflip.png")
# var three_vflip =	preload("res://assets/test_die/icon_3_vflip.png")
# var four_vflip =	preload("res://assets/test_die/icon_4_vflip.png")
# var five_vflip =	preload("res://assets/test_die/icon_5_vflip.png")
# var six_vflip =		preload("res://assets/test_die/icon_6_vflip.png")
#
# var one_hflip =		preload("res://assets/test_die/icon_1_hflip.png")
# var two_hflip =		preload("res://assets/test_die/icon_2_hflip.png")
# var three_hflip =	preload("res://assets/test_die/icon_3_hflip.png")
# var four_hflip =	preload("res://assets/test_die/icon_4_hflip.png")
# var five_hflip =	preload("res://assets/test_die/icon_5_hflip.png")
# var six_hflip =		preload("res://assets/test_die/icon_6_hflip.png")

onready var tp = TexturePacks.get_texturepack(TexturePacks.TP_INDEX.GODOT_TP)

var texture_arr
var texture_arr_vflip
var texture_arr_hflip

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

	texture_arr = tp.texture_arr
	texture_arr_vflip = tp.texture_arr_vflip
	texture_arr_hflip = tp.texture_arr_hflip
#	position = screen_size/2
	sprite.set_texture(texture_arr[0])
	sprite2.set_texture(texture_arr[0])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(right_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(true,false,false,false)
		if roll_progress == 1.0:
			sprite.set_texture(texture_arr[die_face.top - 1])
			right_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	elif(left_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,true,false,false)
		if roll_progress == 1.0:
			sprite2.set_texture(texture_arr[die_face.top - 1])
			print(die_face)
			left_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	elif(up_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,false,true,false)
		if roll_progress == 1.0:
			sprite2.set_texture(texture_arr[die_face.top -1])
			up_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	elif(down_roll_flag):
		roll_progress = clamp(roll_progress + 0.1, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,false,false,true)
		if roll_progress == 1.0:
			sprite2.set_texture(texture_arr[die_face.top -1])
			down_roll_flag = false
			roll_progress = 0
			set_shader(false,false,false,false)
	pass


#func _input(_event):
#	if Input.is_action_just_pressed("ui_right"):
#		position += Vector2(PLAYER_WIDTH,0)
#		if(right_roll_flag == false):
#			roll(DIR_RIGHT)
#			right_roll_flag = true
#	elif Input.is_action_just_pressed("ui_left"):
#		position += Vector2(-PLAYER_WIDTH,0)
#		if(left_roll_flag == false):
#			roll(DIR_LEFT)
#			left_roll_flag = true
#	elif Input.is_action_just_pressed("ui_up"):
#		position += Vector2(0,-PLAYER_HEIGHT)
#		if(up_roll_flag == false):
#			roll(DIR_UP)
#			up_roll_flag = true
#	elif Input.is_action_just_pressed("ui_down"):
#		position += Vector2(0,PLAYER_HEIGHT)
#		if(down_roll_flag == false):
#			roll(DIR_DOWN)
#			down_roll_flag = true


func move(direction):
	match direction:
		"right":
			position += Vector2(PLAYER_WIDTH,0)
			if(right_roll_flag == false):
				roll(DIR_RIGHT)
				right_roll_flag = true
		"left":
			position += Vector2(-PLAYER_WIDTH,0)
			if(left_roll_flag == false):
				roll(DIR_LEFT)
				left_roll_flag = true
		"up":
			position += Vector2(0,-PLAYER_HEIGHT)
			if(up_roll_flag == false):
				roll(DIR_UP)
				up_roll_flag = true
		"down":
			position += Vector2(0,PLAYER_HEIGHT)
			if(down_roll_flag == false):
				roll(DIR_DOWN)
				down_roll_flag = true


func get_top_value():
	return die_face.top


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

func roll(direction):
	if direction == DIR_RIGHT:
		sprite.set_texture(texture_arr[die_face.top - 1]) # Gotta shift for zero indexing
		sprite2.set_texture(texture_arr[die_face.right - 1]) # Gotta shift for zero indexing
		var top = die_face.right
		var left = die_face.top
		var bot = die_face.left
		var right = die_face.bot
		die_face.right = right
		die_face.top = top
		die_face.left = left
		die_face.bot = bot
	if direction == DIR_LEFT:
		sprite2.set_texture(texture_arr[die_face.top - 1]) # Gotta shift for zero indexing
		sprite.set_texture(texture_arr_hflip[die_face.left - 1]) # Gotta shift for zero indexing
		var bot = die_face.right
		var right = die_face.top
		var top = die_face.left
		var left = die_face.bot
		die_face.right = right
		die_face.top = top
		die_face.left = left
		die_face.bot = bot
	if direction == DIR_UP:
		sprite.set_texture(texture_arr[die_face.top - 1]) # Gotta shift for zero indexing
		sprite2.set_texture(texture_arr_vflip[die_face.up - 1]) # Gotta shift for zero indexing
		var bot = die_face.down
		var down = die_face.top
		var top = die_face.up
		var up = die_face.bot
		die_face.down = down
		die_face.top = top
		die_face.up = up
		die_face.bot = bot
	if direction == DIR_DOWN:
		sprite2.set_texture(texture_arr_vflip[die_face.top - 1]) # Gotta shift for zero indexing
		sprite.set_texture(texture_arr[die_face.down - 1]) # Gotta shift for zero indexing
		var top = die_face.down
		var up = die_face.top
		var bot = die_face.up
		var down = die_face.bot
		die_face.down = down
		die_face.top = top
		die_face.up = up
		die_face.bot = bot


