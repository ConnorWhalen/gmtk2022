extends Node2D

signal mode_menu


func _on_Back_pressed():
	emit_signal("mode_menu")
#	get_tree().change_scene("res://scenes/Menu.tscn")
