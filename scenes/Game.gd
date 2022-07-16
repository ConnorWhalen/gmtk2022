extends Node2D


onready var Chip = preload("res://scenes/Chip.tscn")
onready var Special = preload("res://scenes/Special.tscn")
onready var Card = preload("res://scenes/Cards.tscn")

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var TILE_SIZE = 64
var RIGHT_BOUND = SCREEN_WIDTH/TILE_SIZE - 2
var BOTTOM_BOUND = SCREEN_HEIGHT/TILE_SIZE - 2

var CHIP_TIME_MIN = 1.5
var CHIP_TIME_MAX = 3
var SPECIAL_TIME_MIN = 5
var SPECIAL_TIME_MAX = 10
var CARD_TIME_MIN = 4
var CARD_TIME_MAX = 6

var chips = []
var specials = []
var cards = []
var player_tile = [0, 0]
var rng
var health = 3
var hit_lock = false


func _ready():
	$ChipTimer.start()
	$SpecialTimer.start()
	$CardTimer.start()
	rng = RandomNumberGenerator.new()
	
	player_tile = [6, 3]
	$Player.position = Vector2(
		(player_tile[0] + 1.5) * TILE_SIZE,
		(player_tile[1] + 1.5) * TILE_SIZE
	)


func _process(delta):
	cull(chips)
	cull(specials)
	cull(cards)
	
	for special in specials:
		if special.tile == player_tile and $Player.get_top_value() == special.value:
			apply_special()
			special.dead = true
	
	for card in cards:
		if card.is_down() and card.tile == player_tile:
			hit()

	show_indicator()

func _physics_process(delta):
	for chip in chips:
		var collision = chip.do_move_and_collide()
		if collision:
			hit()
			chip.dead = true



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


func cull(nodes):
	for i in range(nodes.size()-1, -1, -1):
		var node = nodes[i]
		if node.dead:
			remove_child(node)
			nodes.remove(i)


func hit():
	if not hit_lock:
		hit_lock = true
		health -= 1
		update_health()
		
		$Player.visible = false
		if health > 0:
			yield(get_tree().create_timer(0.2, false), "timeout")
			$Player.visible = true
			yield(get_tree().create_timer(0.2, false), "timeout")
			$Player.visible = false
			yield(get_tree().create_timer(0.2, false), "timeout")
			$Player.visible = true
			yield(get_tree().create_timer(0.2, false), "timeout")
			$Player.visible = false
			yield(get_tree().create_timer(0.2, false), "timeout")
			$Player.visible = true
			yield(get_tree().create_timer(0.2, false), "timeout")
			hit_lock = false


func apply_special():
	health += 1
	update_health()


func update_health():
	$HealthLabel.text = "x " + str(health)


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


func set_timer_wait(timer, min_wait, max_wait):
	rng.randomize()
	timer.wait_time = rng.randf_range(min_wait, max_wait)


func _on_ChipTimer_timeout():
	var chip = Chip.instance()
	chip.z_index = 2
	add_child(chip)
	chips.append(chip)
	set_timer_wait($ChipTimer, CHIP_TIME_MIN, CHIP_TIME_MAX)


func _on_SpecialTimer_timeout():
	var special = Special.instance()
	special.set_tile(get_random_tile())
	add_child(special)
	specials.append(special)
	set_timer_wait($SpecialTimer, SPECIAL_TIME_MIN, SPECIAL_TIME_MAX)


func _on_CardTimer_timeout():
	var card = Card.instance()
	card.z_index = 1
	card.set_tile(get_random_tile())
	add_child(card)
	cards.append(card)
	set_timer_wait($CardTimer, CARD_TIME_MIN, CARD_TIME_MAX)

func show_indicator():
	var north_value = $Player.die_face.up
	$IndicatorN.set_value(north_value)
	$IndicatorN.set_position($Player.get_position() + Vector2(0, -64))
	var east_value = $Player.die_face.right
	$IndicatorE.set_value(east_value)
	$IndicatorE.set_position($Player.get_position() + Vector2(64, 0))
	var west_value = $Player.die_face.left
	$IndicatorW.set_value(west_value)
	$IndicatorW.set_position($Player.get_position() + Vector2(-64, 0))
	var south_value = $Player.die_face.down
	$IndicatorS.set_value(south_value)
	$IndicatorS.set_position($Player.get_position() + Vector2(0, 64))
