extends Node2D


onready var Chip = preload("res://scenes/Chip.tscn")
onready var Special = preload("res://scenes/Special.tscn")

var chips = []
var specials = []


func _ready():
	$ChipTimer.start()
	$SpecialTimer.start()


func _process(delta):
	cull(chips)
	cull(specials)
			


func _on_ChipTimer_timeout():
	var chip = Chip.instance()
	chip.z_index = 1
	add_child(chip)
	chips.append(chip)


func _on_SpecialTimer_timeout():
	var special = Special.instance()
	add_child(special)
	specials.append(special)


func cull(nodes):
	for i in range(nodes.size()-1, -1, -1):
		var node = nodes[i]
		if node.dead:
			remove_child(node)
			nodes.remove(i)
