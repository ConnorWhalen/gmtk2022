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

func _on_ResetSave_pressed():
	Save.reset_stats()
