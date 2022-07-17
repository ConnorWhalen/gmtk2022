extends Control

signal mode_menu

onready var Special = preload("res://scenes/Special.tscn")


var RIGHT_BOUND = 6
var BOTTOM_BOUND = 4

var player_tile = [2, 1]
var specials = []
var rng


func _ready():
	$SpecialTimer.start()
	rng = RandomNumberGenerator.new()


func _process(delta):
	if $Player.is_rolling():
		hide_indicator()
	else:
		show_indicator()
	
	if $Dollar.visible:
		$Dollar.position.y -= 1
	
	if len(specials) > 0:
		if specials[0].dead:
			remove_child(specials[0])
			specials.remove(0)
			$SpecialTimer.start()
			
	for special in specials:
		if special.tile == player_tile and $Player.get_top_value() == special.value:
			apply_special(special.position)
			special.dead = true


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
	if not $Player.is_rolling():
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
			if $Player.move(direction):
				player_tile = next_tile


func is_tile_in_bounds(x, y):
	return x >= 0 and x < RIGHT_BOUND and y >= 0 and y < BOTTOM_BOUND


func get_random_tile():
	var tile = [-1, -1]
	while not is_tile_in_bounds(tile[0], tile[1]):
		rng.randomize()
		tile[0] = rng.randi() % RIGHT_BOUND
		rng.randomize()
		tile[1] = rng.randi() % BOTTOM_BOUND
	return tile


func apply_special(pos):
	$Dollar.position = pos + Vector2(32, 32)
	$Dollar.visible = true
	yield(get_tree().create_timer(1, false), "timeout")
	$Dollar.visible = false


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


func _on_SpecialTimer_timeout():
	var special = Special.instance()
	special.set_tile(get_random_tile())
	special.position += Vector2(-256, 64)
	add_child(special)
	specials.append(special)
