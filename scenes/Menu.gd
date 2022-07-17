extends Node2D

signal mode_game
signal mode_options
signal mode_howto

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StartButton_pressed():
	emit_signal("mode_game")
#	get_tree().change_scene("res://scenes/Game.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	emit_signal("mode_options")
#	get_tree().change_scene("res://scenes/options.tscn")



func _on_HowToButton_pressed():
	emit_signal("mode_howto")
#	get_tree().change_scene("res://scenes/HowTo.tscn")
