extends Node2D

signal mode_game


func _ready():
	pass


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		emit_signal("mode_game")
