extends Node2D

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")

export var SPEED = 2
export var BUFFER = 32

enum ChipType {
	ROTATE = 0,
	SPIN = 1,
	TYPE_max = 2
}

var dead: bool = false
var direction: Vector2
var chip_type
var rng
var elapsed = 0


func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	var start_face: int = rng.randi() % 4
	var end_face: int = (start_face + 2) % 4
	var start_pos: Vector2 = find_random_position(start_face)
	var end_pos: Vector2 = find_random_position(end_face)
	position = start_pos
	direction = (end_pos - start_pos).normalized()
	
	rng.randomize()
	chip_type = ChipType.values()[rng.randi() % ChipType.TYPE_max]


func _process(delta):
	elapsed += delta
	position += (direction * SPEED)
	match chip_type:
		ChipType.ROTATE:
			$Sprite.rotation_degrees += 1
		ChipType.SPIN:
			$Sprite.scale.x = cos(elapsed*6)
	if (position.x < -BUFFER*2 or position.x > SCREEN_WIDTH + BUFFER*2 or
		position.y < -BUFFER*2 or position.y > SCREEN_HEIGHT + BUFFER*2
	):
		dead = true


func is_dead():
	return dead


func find_random_position(face: int) -> Vector2:
	var pos = Vector2()
	rng.randomize()
	match face:
		0:# left
			pos.x = -BUFFER
			pos.y = rng.randi() % SCREEN_HEIGHT
		1:# up
			pos.x = rng.randi() % SCREEN_WIDTH
			pos.y = -BUFFER
		2:# right
			pos.x = SCREEN_WIDTH + BUFFER
			pos.y = rng.randi() % SCREEN_HEIGHT
		3:# down
			pos.x = rng.randi() % SCREEN_WIDTH
			pos.y = SCREEN_HEIGHT + BUFFER
	return pos
