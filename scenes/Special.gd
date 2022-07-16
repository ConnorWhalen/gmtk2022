extends Node2D

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var TILE_SIZE = 64

export var value: int = 1
var dead: bool = false
var tile = [0, 0]


func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	value = rng.randi() % 6
	$Label.text = str(value)
	
#	rng.randomize()
#	tile[0] = rng.randi() % (SCREEN_WIDTH/TILE_SIZE)
#	rng.randomize()
#	tile[1] = rng.randi() % (SCREEN_HEIGHT/TILE_SIZE)
#	position = Vector2(tile[0]*TILE_SIZE, tile[1]*TILE_SIZE)


func set_tile(tile_):
	tile = tile_
	position = Vector2((tile[0]+1) * TILE_SIZE, (tile[1]+1) * TILE_SIZE)


func _process(delta):
	pass


func _on_DeathTimer_timeout():
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	visible = false
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	visible = true
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	visible = false
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	visible = true
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	visible = false
	dead = true
