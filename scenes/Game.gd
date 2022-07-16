extends Node2D


onready var Chip = preload("res://scenes/Chip.tscn")
onready var Special = preload("res://scenes/Special.tscn")

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var TILE_SIZE = 64
var RIGHT_BOUND = SCREEN_WIDTH/TILE_SIZE - 2
var BOTTOM_BOUND = SCREEN_HEIGHT/TILE_SIZE - 2

var chips = []
var specials = []
var player_tile = [0, 0]
var rng


func _ready():
	$ChipTimer.start()
	$SpecialTimer.start()
	rng = RandomNumberGenerator.new()
	
	player_tile = [6, 3]
	$Player.position = Vector2(
		(player_tile[0] + 1.5) * TILE_SIZE,
		(player_tile[1] + 1.5) * TILE_SIZE
	)


func _process(delta):
	cull(chips)
	cull(specials)


func _input(_event):
	if Input.is_action_just_pressed("ui_right"):
		try_move_player("right")
	elif Input.is_action_just_pressed("ui_left"):
		try_move_player("left")
	elif Input.is_action_just_pressed("ui_up"):
		try_move_player("up")
	elif Input.is_action_just_pressed("ui_down"):
		try_move_player("down")


func try_move_player(direction):
	var next_tile = [player_tile[0], player_tile[1]]
	match direction:
		"right":
			next_tile[0] += 1
		"left":
			next_tile[0] -= 1
		"up":
			next_tile[1] -= 1
		"down":
			next_tile[1] += 1
	if is_tile_in_bounds(next_tile[0], next_tile[1]):
		$Player.move(direction)
		player_tile = next_tile


func _on_ChipTimer_timeout():
	var chip = Chip.instance()
	chip.z_index = 1
	add_child(chip)
	chips.append(chip)


func _on_SpecialTimer_timeout():
	var special = Special.instance()
	special.set_tile(get_random_tile())
	add_child(special)
	specials.append(special)


func cull(nodes):
	for i in range(nodes.size()-1, -1, -1):
		var node = nodes[i]
		if node.dead:
			remove_child(node)
			nodes.remove(i)


func get_random_tile():
	var tile = [0, 0]
	while not is_tile_in_bounds(tile[0], tile[1]):
		rng.randomize()
		tile[0] = rng.randi() % RIGHT_BOUND
		rng.randomize()
		tile[1] = rng.randi() % BOTTOM_BOUND
	return tile


func is_tile_in_bounds(x, y):
	if x < 0 or x >= RIGHT_BOUND:
		return false
	if y < 0 or y >= BOTTOM_BOUND:
		return false
	var corner_tiles = [
		[0, 0],
		[0, 1],
		[1, 0]
	]
	for corner_tile in corner_tiles:
		if (x == corner_tile[0] and y == corner_tile[1] or
			x == RIGHT_BOUND - corner_tile[0] - 1 and y == corner_tile[1] or
			x == corner_tile[0] and y == BOTTOM_BOUND - corner_tile[1] - 1 or
			x == RIGHT_BOUND - corner_tile[0] - 1 and y == BOTTOM_BOUND - corner_tile[1] - 1
		):
			return false
	return true
