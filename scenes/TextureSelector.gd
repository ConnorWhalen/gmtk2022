extends Node2D

var tp_index
var texture_arr
var texture_arr_vflip
var texture_arr_hflip
var save_stats

var right_roll_flag = true
var left_roll_flag = false
var up_roll_flag = false
var down_roll_flag = false

var roll_progress = 0

var speed = 0.02

onready var sprite = $Sprite
onready var sprite2 = $Sprite2

enum {DIR_RIGHT, DIR_LEFT, DIR_UP, DIR_DOWN}

var die_face = {"top": 1, "up": 5, "down": 2, "right": 4, "left": 3, "bot": 6}

# Called when the node enters the scene tree for the first time.
func _ready():
	save_stats = Save.pull_stats()
	tp_index = save_stats["texture_pack"]
	var tp = TexturePacks.get_texturepack(tp_index)
	texture_arr = tp.texture_arr
	texture_arr_vflip = tp.texture_arr_vflip
	texture_arr_hflip = tp.texture_arr_hflip
	sprite.set_texture(texture_arr[die_face.left - 1])
	sprite2.set_texture(texture_arr[die_face.top - 1])
	pass # Replace with function body.

func _process(delta):
	if(right_roll_flag):
		roll_progress = clamp(roll_progress + speed, 0, 1.0)
		set_progress(roll_progress)
		set_shader(true,false,false,false)
		if roll_progress == 1.0:
			print('r')
			left_roll_flag = true
			roll(DIR_LEFT)
#			sprite.set_texture(texture_arr[die_face.top - 1])
			right_roll_flag = false
			roll_progress = 0
#			set_shader(false,false,false,false)
	elif(left_roll_flag):
		roll_progress = clamp(roll_progress + speed, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,true,false,false)
		if roll_progress == 1.0:
			print('l')
			roll(DIR_UP)
			up_roll_flag = true
#			sprite2.set_texture(texture_arr[die_face.top - 1])
			left_roll_flag = false
			roll_progress = 0
#			set_shader(false,false,false,false)
	elif(up_roll_flag):
		roll_progress = clamp(roll_progress + speed, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,false,true,false)
		if roll_progress == 1.0:
			print('u')
			roll(DIR_LEFT)
			left_roll_flag = true
#			sprite2.set_texture(texture_arr[die_face.top -1])
			up_roll_flag = false
			roll_progress = 0
#			set_shader(false,false,false,false)
	elif(down_roll_flag):
		roll_progress = clamp(roll_progress + speed, 0, 1.0)
		set_progress(roll_progress)
		set_shader(false,false,false,true)
		if roll_progress == 1.0:
			print('d')
			roll(DIR_RIGHT)
			right_roll_flag = true
#			sprite2.set_texture(texture_arr[die_face.top -1])
			down_roll_flag = false
			roll_progress = 0
#			set_shader(false,false,false,false)
	pass


func _on_ButtonLeft_button_down():
	tp_index = int(fposmod((tp_index - 1),TexturePacks.TP_INDEX.TP_INDEX_max))
	var tp = TexturePacks.get_texturepack(tp_index)
	texture_arr = tp.texture_arr
	texture_arr_vflip = tp.texture_arr_vflip
	texture_arr_hflip = tp.texture_arr_hflip
	print("Left")

func _on_ButtonRight_button_down():
	tp_index = int(fposmod((tp_index + 1),TexturePacks.TP_INDEX.TP_INDEX_max))
	var tp = TexturePacks.get_texturepack(tp_index)
	texture_arr = tp.texture_arr
	texture_arr_vflip = tp.texture_arr_vflip
	texture_arr_hflip = tp.texture_arr_hflip
	print("Right")

func _on_ConfirmButton_pressed():
	save_stats = Save.pull_stats()
	save_stats["texture_pack"] = tp_index
	Save.save_data = save_stats
	Save.push_stats()
	print("Confirm")

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
		sprite.set_texture(texture_arr_hflip[die_face.top - 1]) # Gotta shift for zero indexing
		sprite2.set_texture(texture_arr[die_face.right - 1]) # Gotta shift for zero indexing
#		print(texture_arr_hflip[die_face.top - 1], texture_arr[die_face.right - 1])
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
#		print(texture_arr_hflip[die_face.left - 1], texture_arr[die_face.top - 1])
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
#		print(texture_arr[die_face.top - 1],texture_arr_vflip[die_face.up - 1])
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
