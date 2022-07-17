extends Node2D

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")
var SIZE = 128
var TILE_SIZE = 64
var FALL_SPEED = 200

enum CardState {
	WARNING,
	SLAMMING,
	DOWN
}

var dead = false
var tile = [0, 0]
var state = CardState.WARNING
var rng


func _ready():
	$Container.position.y = SIZE
	$Container.scale.y = 0
	
	rng = RandomNumberGenerator.new()
	set_card_sprite($Container/Card1)
	set_card_sprite($Container/Card2)
	
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	$Warning.visible = false
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	$Warning.visible = true
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	$Warning.visible = false
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	$Warning.visible = true
	yield(get_tree().create_timer(0.5, false), "timeout")
	if get_tree() == null:
		return
	$Warning.visible = false
	$Container.visible = true
	state = CardState.SLAMMING


func _process(delta):
	match state:
		CardState.SLAMMING:
			$Container.position.y -= delta * FALL_SPEED
			$Container.scale.y = 1 - ($Container.position.y / SIZE)
			if $Container.position.y <= 0:
				$Container.position.y = 0
				$Container.scale.y = 1
				$Container/Slam.visible = true
				state = CardState.DOWN
				yield(get_tree().create_timer(0.5, false), "timeout")
				if get_tree() == null:
					return
				$Container/Slam.visible = false
				dead = true


func set_tile(tile_):
	tile = tile_
	position = Vector2((tile[0]+1.5) * TILE_SIZE, (tile[1]+1.5) * TILE_SIZE)
	var direction = Vector2(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) - position
	rotation = direction.angle() + PI/2
	$Warning.rotation = -rotation


func is_down():
	return state == CardState.DOWN


func set_card_sprite(sprite):
	rng.randomize()
	sprite.region_rect.position.x = SIZE * (rng.randi() % 4)
