extends Node2D

signal mode_menu
signal mode_game

var BASE_COST = 2000
var COST_WEIGHT = 1000

var upgrade0 = ["SpeedIcon", "SpeedCount", "SpeedCost"]
var upgrade1 = ["FadeIcon", "FadeCount", "FadeCost"]
var upgrade2 = ["HealthIcon", "HealthCount", "HealthCost"]
var upgrades = [upgrade0, upgrade1, upgrade2]

var X_POSITIONS = [120, 430, 600, 715]
var Y_POSITIONS = [200, 300, 400, 500]

var LEAVE_ARROW_POSITION = Vector2(X_POSITIONS[0], Y_POSITIONS[-1])

var choices = []

var current_selection

var up_debounce = true
var down_debounce = true
var enter_debounce = true

var save_stats

func _ready():
	save_stats = Save.save_data

	for i in range(len(upgrades)):
		get_node(upgrades[i][0]).position = Vector2(X_POSITIONS[1], Y_POSITIONS[i])
		get_node(upgrades[i][1]).rect_position = Vector2(X_POSITIONS[2], Y_POSITIONS[i]-38)
		get_node(upgrades[i][1]).rect_size.x = 240
		get_node(upgrades[i][2]).rect_position = Vector2(X_POSITIONS[3], Y_POSITIONS[i]-38)
		get_node(upgrades[i][2]).rect_size.x = 240


	init()


func init():
	for i in range(Save.STAT_INDEX.STAT_INDEX_max):
		choices.append(
			{
			"cost": BASE_COST + COST_WEIGHT*save_stats["stats"][i]["count"],
			"count": save_stats["stats"][i],
			"arrow_position": Vector2(X_POSITIONS[0], Y_POSITIONS[i]),
			"cost_label": upgrades[i][2],
			"count_label": upgrades[i][1]
			})
	choices.append({
		"arrow_position": LEAVE_ARROW_POSITION
	})

	for i in range(choices.size()-1):
		var choice = choices[i]
		choice["count"] = save_stats["stats"][i]["count"]
		get_node(choice["cost_label"]).text = "$" + str(choice["cost"])
		get_node(choice["count_label"]).text = str(choice["count"])
	$Cash.text = "$" + str(save_stats["cash"])

	set_selection(0)


func _process(delta):
	var up_pressed = Input.is_action_pressed("ui_up") and not up_debounce
	up_debounce = Input.is_action_pressed("ui_up")
	var down_pressed = Input.is_action_pressed("ui_down") and not down_debounce
	down_debounce = Input.is_action_pressed("ui_down")
	var enter_pressed = Input.is_action_pressed("ui_accept") and not enter_debounce
	enter_debounce = Input.is_action_pressed("ui_accept")

	if up_pressed:
		if current_selection == 0:
			set_selection(choices.size()-1)
		else:
			set_selection(current_selection-1)
	if down_pressed:
		if current_selection == choices.size()-1:
			set_selection(0)
		else:
			set_selection(current_selection+1)
	if enter_pressed:
		select_option(current_selection)

	var mouse_pos = get_global_mouse_position()
	for i in range(len(Y_POSITIONS)):
		if ( (mouse_pos.y < Y_POSITIONS[i] + 25 && mouse_pos.y > Y_POSITIONS[i] - 25)):
			set_selection(i)

func _input(event):
	if (event is InputEventMouseButton) && event.is_pressed() && event.button_index == BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		for i in range(len(Y_POSITIONS)):
			if ( (mouse_pos.y < Y_POSITIONS[i] + 25 && mouse_pos.y > Y_POSITIONS[i] - 25)):
				select_option(i)
	else:
		pass

func set_selection(index):
	current_selection = index
	$Arrow.position = choices[index]["arrow_position"]

func select_option(index):
	if index < choices.size()-1:
		try_buy(index)
	else:
		emit_signal("mode_menu")


func try_buy(index):
	var cost = choices[index]["cost"]
	var count = choices[index]["count"]

	if cost <= save_stats["cash"]:
		save_stats["cash"] -= cost
		count += 1

		choices[index]["count"] = count
		save_stats["stats"][index]["count"] = count
		get_node(choices[index]["count_label"]).text = str(count)
		$Cash.text = "$" + str(save_stats["cash"])
		choices[index]["cost"] = BASE_COST + COST_WEIGHT*save_stats["stats"][index]["count"]
		get_node(choices[index]["cost_label"]).text = "$" + str(choices[index]["cost"])

		Save.push_stats()
