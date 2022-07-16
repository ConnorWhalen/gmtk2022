extends Control

signal mode_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StartButton_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")



func _on_QuitButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://scenes/options.tscn")



func _on_HowToButton_pressed():
	get_tree().change_scene("res://scenes/HowTo.tscn")
