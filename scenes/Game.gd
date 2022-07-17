extends Node2D

signal mode_menu
signal exit_game

onready var Chip = preload("res://scenes/Chip.tscn")
onready var Special = preload("res://scenes/Special.tscn")
onready var Card = preload("res://scenes/Cards.tscn")

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var TILE_SIZE = 64
var RIGHT_BOUND = SCREEN_WIDTH/TILE_SIZE - 2
var BOTTOM_BOUND = SCREEN_HEIGHT/TILE_SIZE - 2

var chip_time_min = 2
var chip_time_max = 4
var special_time_min = 10
var special_time_max = 15
var card_time_min = 8
var card_time_max = 12

var CHIP_RATE_MAX = 0.2
var CHIP_INCREASE_RATE = 0.99
var CARD_RATE_MAX = 0.1
var CARD_INCREASE_RATE = 0.97

var SCORE_SPEED = 20
var SPECIAL_POINTS = 1000

var chips = []
var specials = []
var cards = []
var player_tile = [0, 0]
var rng
var health = 3
var score = 0
var hit_lock = false
var player_dead = false


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
	
	if not player_dead:
		score += delta * SCORE_SPEED
		update_score()

	for special in specials:
		if special.tile == player_tile and $Player.get_top_value() == special.value:
			apply_special(special.position)
			special.dead = true
	
	for card in cards:
		if card.is_down() and card.tile == player_tile:
			hit()

	if $Player.is_rolling():
		hide_indicator()
	else:
		show_indicator()
	
	if $Dollar.visible:
		$Dollar.position.y -= 1

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
		if health == 0:
			player_dead = true
		else:
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


func apply_special(pos):
	health += 1
	update_health()
	score += SPECIAL_POINTS
	update_score()
	
	$Dollar.position = pos + Vector2(32, 32)
	$Dollar.visible = true
	yield(get_tree().create_timer(1, false), "timeout")
	$Dollar.visible = false
	


func update_health():
	$HealthLabel.text = str(health)


func update_score():
	$CashLabel.text = str(int(score/100) * 100)


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
	set_timer_wait($ChipTimer, chip_time_min, chip_time_max)
	chip_time_min = pow(chip_time_min+CHIP_RATE_MAX, CHIP_INCREASE_RATE) - CHIP_RATE_MAX
	chip_time_max = pow(chip_time_max+CHIP_RATE_MAX, CHIP_INCREASE_RATE) - CHIP_RATE_MAX
	print("CHIP TIME: " + str(chip_time_min) + " - " + str(chip_time_max))


func _on_SpecialTimer_timeout():
	var special = Special.instance()
	special.set_tile(get_random_tile())
	add_child(special)
	specials.append(special)
	set_timer_wait($SpecialTimer, special_time_min, special_time_max)


func _on_CardTimer_timeout():
	var card = Card.instance()
	card.z_index = 1
	card.set_tile(get_random_tile())
	add_child(card)
	cards.append(card)
	set_timer_wait($CardTimer, card_time_min, card_time_max)
	card_time_min = pow(card_time_min+CHIP_RATE_MAX, CARD_INCREASE_RATE) - CHIP_RATE_MAX
	card_time_max = pow(card_time_max+CHIP_RATE_MAX, CARD_INCREASE_RATE) - CHIP_RATE_MAX
	print("CARD TIME: " + str(card_time_min) + " - " + str(card_time_max))
	

func show_indicator():
	var north_value = $Player.get_north_value()
	$IndicatorN.fade_in()
	$IndicatorE.fade_in()
	$IndicatorS.fade_in()
	$IndicatorW.fade_in()

	$IndicatorN.set_value(north_value)
	$IndicatorN.set_position($Player.get_position() + Vector2(0, -64))
	var east_value = $Player.get_east_value()
	$IndicatorE.set_value(east_value)
	$IndicatorE.set_position($Player.get_position() + Vector2(64, 0))
	var west_value = $Player.get_west_value()
	$IndicatorW.set_value(west_value)
	$IndicatorW.set_position($Player.get_position() + Vector2(-64, 0))
	var south_value = $Player.get_south_value()
	$IndicatorS.set_value(south_value)
	$IndicatorS.set_position($Player.get_position() + Vector2(0, 64))

func hide_indicator():
	$IndicatorN.visible = false
	$IndicatorE.visible = false
	$IndicatorS.visible = false
	$IndicatorW.visible = false


func _on_CanvasLayer_exit_game():
	emit_signal("mode_menu")
