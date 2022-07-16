extends Node2D


onready var Chip = preload("res://scenes/Chip.tscn")

var chips = []


func _ready():
	$ChipTimer.start()


func _process(delta):
	for i in range(chips.size()-1, -1, -1):
		var chip = chips[i]
		if chip.dead:
			remove_child(chip)
			chips.remove(i)
			


func _on_ChipTimer_timeout():
	var chip = Chip.instance()
	add_child(chip)
	chips.append(chip)
