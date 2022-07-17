extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum TP_INDEX {DEFAULT_TP, RED_TP, PURP_TP, ORANGE_TP, GREY_TP, BLUE_TP, COLOURFUL_TP, GODOT_TP, TEST_TP, TP_INDEX_max}

# Default values as the test texture pack
var one_texture =	preload("res://assets/test_die/icon_1.png")
var two_texture =	preload("res://assets/test_die/icon_2.png")
var three_texture =	preload("res://assets/test_die/icon_3.png")
var four_texture =	preload("res://assets/test_die/icon_4.png")
var five_texture =	preload("res://assets/test_die/icon_5.png")
var six_texture =	preload("res://assets/test_die/icon_6.png")

var one_vflip =		preload("res://assets/test_die/icon_1_vflip.png")
var two_vflip =		preload("res://assets/test_die/icon_2_vflip.png")
var three_vflip =	preload("res://assets/test_die/icon_3_vflip.png")
var four_vflip =	preload("res://assets/test_die/icon_4_vflip.png")
var five_vflip =	preload("res://assets/test_die/icon_5_vflip.png")
var six_vflip =		preload("res://assets/test_die/icon_6_vflip.png")

var one_hflip =		preload("res://assets/test_die/icon_1_hflip.png")
var two_hflip =		preload("res://assets/test_die/icon_2_hflip.png")
var three_hflip =	preload("res://assets/test_die/icon_3_hflip.png")
var four_hflip =	preload("res://assets/test_die/icon_4_hflip.png")
var five_hflip =	preload("res://assets/test_die/icon_5_hflip.png")
var six_hflip =		preload("res://assets/test_die/icon_6_hflip.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_texturepack(tp_index):
	match tp_index:
		TP_INDEX.GODOT_TP:
			one_texture =	preload("res://assets/godot_die/icon_1.png")
			two_texture =	preload("res://assets/godot_die/icon_2.png")
			three_texture =	preload("res://assets/godot_die/icon_3.png")
			four_texture =	preload("res://assets/godot_die/icon_4.png")
			five_texture =	preload("res://assets/godot_die/icon_5.png")
			six_texture =	preload("res://assets/godot_die/icon_6.png")

			one_vflip =		preload("res://assets/godot_die/icon_1_vflip.png")
			two_vflip =		preload("res://assets/godot_die/icon_2_vflip.png")
			three_vflip =	preload("res://assets/godot_die/icon_3_vflip.png")
			four_vflip =	preload("res://assets/godot_die/icon_4_vflip.png")
			five_vflip =	preload("res://assets/godot_die/icon_5_vflip.png")
			six_vflip =		preload("res://assets/godot_die/icon_6_vflip.png")

			one_hflip =		one_texture
			two_hflip =		two_texture
			three_hflip =	three_texture
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture
		TP_INDEX.TEST_TP:
			pass # Use defaults
		TP_INDEX.DEFAULT_TP:
			one_texture =	preload("res://assets/default_die/Dice 1.png")
			two_texture =	preload("res://assets/default_die/Dice 2.png")
			three_texture =	preload("res://assets/default_die/Dice 3.png")
			four_texture =	preload("res://assets/default_die/Dice 4.png")
			five_texture =	preload("res://assets/default_die/Dice 5.png")
			six_texture =	preload("res://assets/default_die/Dice 6.png")

			one_vflip =		one_texture
			two_vflip =		preload("res://assets/default_die/Dice 2_vflip.png")
			three_vflip =	preload("res://assets/default_die/Dice 3_vflip.png")
			four_vflip =	four_texture
			five_vflip =	five_texture
			six_vflip =		six_texture

			one_hflip =		one_texture
			two_hflip =		two_vflip
			three_hflip =	three_vflip
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture
		TP_INDEX.RED_TP:
			one_texture =	preload("res://assets/colored_die/Dice 1 Red.png")
			two_texture =	preload("res://assets/colored_die/Dice 2 Red.png")
			three_texture =	preload("res://assets/colored_die/Dice 3 Red.png")
			four_texture =	preload("res://assets/colored_die/Dice 4 Red.png")
			five_texture =	preload("res://assets/colored_die/Dice 5 Red.png")
			six_texture =	preload("res://assets/colored_die/Dice 6 Red.png")

			one_vflip =		one_texture
			two_vflip =		preload("res://assets/colored_die/Dice 2 Red_vflip.png")
			three_vflip =	preload("res://assets/colored_die/Dice 3 Red_vflip.png")
			four_vflip =	four_texture
			five_vflip =	five_texture
			six_vflip =		six_texture

			one_hflip =		one_texture
			two_hflip =		two_vflip
			three_hflip =	three_vflip
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture
		TP_INDEX.PURP_TP:
			one_texture =	preload("res://assets/colored_die/Dice 1 Purp.png")
			two_texture =	preload("res://assets/colored_die/Dice 2 Purp.png")
			three_texture =	preload("res://assets/colored_die/Dice 3 Purp.png")
			four_texture =	preload("res://assets/colored_die/Dice 4 Purp.png")
			five_texture =	preload("res://assets/colored_die/Dice 5 Purp.png")
			six_texture =	preload("res://assets/colored_die/Dice 6 Purp.png")

			one_vflip =		one_texture
			two_vflip =		preload("res://assets/colored_die/Dice 2 Purp_vflip.png")
			three_vflip =	preload("res://assets/colored_die/Dice 3 Purp_vflip.png")
			four_vflip =	four_texture
			five_vflip =	five_texture
			six_vflip =		six_texture

			one_hflip =		one_texture
			two_hflip =		two_vflip
			three_hflip =	three_vflip
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture
		TP_INDEX.ORANGE_TP:
			one_texture =	preload("res://assets/colored_die/Dice 1 Orange.png")
			two_texture =	preload("res://assets/colored_die/Dice 2 Orange.png")
			three_texture =	preload("res://assets/colored_die/Dice 3 Orange.png")
			four_texture =	preload("res://assets/colored_die/Dice 4 Orange.png")
			five_texture =	preload("res://assets/colored_die/Dice 5 Orange.png")
			six_texture =	preload("res://assets/colored_die/Dice 6 Orange.png")

			one_vflip =		one_texture
			two_vflip =		preload("res://assets/colored_die/Dice 2 Orange_vflip.png")
			three_vflip =	preload("res://assets/colored_die/Dice 3 Orange_vflip.png")
			four_vflip =	four_texture
			five_vflip =	five_texture
			six_vflip =		six_texture

			one_hflip =		one_texture
			two_hflip =		two_vflip
			three_hflip =	three_vflip
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture
		TP_INDEX.GREY_TP:
			one_texture =	preload("res://assets/colored_die/Dice 1 Grey.png")
			two_texture =	preload("res://assets/colored_die/Dice 2 Grey.png")
			three_texture =	preload("res://assets/colored_die/Dice 3 Grey.png")
			four_texture =	preload("res://assets/colored_die/Dice 4 Grey.png")
			five_texture =	preload("res://assets/colored_die/Dice 5 Grey.png")
			six_texture =	preload("res://assets/colored_die/Dice 6 Grey.png")

			one_vflip =		one_texture
			two_vflip =		preload("res://assets/colored_die/Dice 2 Grey_vflip.png")
			three_vflip =	preload("res://assets/colored_die/Dice 3 Grey_vflip.png")
			four_vflip =	four_texture
			five_vflip =	five_texture
			six_vflip =		six_texture

			one_hflip =		one_texture
			two_hflip =		two_vflip
			three_hflip =	three_vflip
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture
		TP_INDEX.BLUE_TP:
			one_texture =	preload("res://assets/colored_die/Dice 1 Blue.png")
			two_texture =	preload("res://assets/colored_die/Dice 2 Blue.png")
			three_texture =	preload("res://assets/colored_die/Dice 3 Blue.png")
			four_texture =	preload("res://assets/colored_die/Dice 4 Blue.png")
			five_texture =	preload("res://assets/colored_die/Dice 5 Blue.png")
			six_texture =	preload("res://assets/colored_die/Dice 6 Blue.png")

			one_vflip =		one_texture
			two_vflip =		preload("res://assets/colored_die/Dice 2 Blue_vflip.png")
			three_vflip =	preload("res://assets/colored_die/Dice 3 Blue_vflip.png")
			four_vflip =	four_texture
			five_vflip =	five_texture
			six_vflip =		six_texture

			one_hflip =		one_texture
			two_hflip =		two_vflip
			three_hflip =	three_vflip
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture
		TP_INDEX.COLOURFUL_TP:
			one_texture =	preload("res://assets/default_die/Dice 1.png")
			two_texture =	preload("res://assets/colored_die/Dice 2 Blue.png")
			three_texture =	preload("res://assets/colored_die/Dice 3 Red.png")
			four_texture =	preload("res://assets/colored_die/Dice 4 Purp.png")
			five_texture =	preload("res://assets/colored_die/Dice 5 Orange.png")
			six_texture =	preload("res://assets/colored_die/Dice 6 Grey.png")

			one_vflip =		one_texture
			two_vflip =		preload("res://assets/colored_die/Dice 2 Blue_vflip.png")
			three_vflip =	preload("res://assets/colored_die/Dice 3 Red_vflip.png")
			four_vflip =	four_texture
			five_vflip =	five_texture
			six_vflip =		six_texture

			one_hflip =		one_texture
			two_hflip =		two_vflip
			three_hflip =	three_vflip
			four_hflip =	four_texture
			five_hflip =	five_texture
			six_hflip =		six_texture

	var texture_arr = [one_texture, two_texture, three_texture, four_texture, five_texture, six_texture]
	var texture_arr_vflip = [one_vflip, two_vflip, three_vflip, four_vflip, five_vflip, six_vflip]
	var texture_arr_hflip = [one_hflip, two_hflip, three_hflip, four_hflip, five_hflip, six_hflip]

	return {"texture_arr": texture_arr, "texture_arr_vflip": texture_arr_vflip, "texture_arr_hflip": texture_arr_hflip}


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
