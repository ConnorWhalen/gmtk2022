extends Node2D

signal mode_menu

func _on_Back_pressed():
	emit_signal("mode_menu")
#	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_SelectDice_pressed():
	self.dice_menu = true


func _on_Confirm_pressed():
#	get_tree().change_scene("res://scenes/options.tscn")
	self.dice_menu = false


var dice_menu = false setget set_dice_menu

func set_dice_menu(value):
	dice_menu = value
	get_tree().paused = dice_menu
	visible = dice_menu
