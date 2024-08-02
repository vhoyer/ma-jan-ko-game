extends Node2D

func _process(_delta):
	if (Input.is_action_just_pressed("ui_accept")):
		$Tagarela.visible = true
	elif (Input.is_action_just_pressed("ui_cancel")):
		$Tagarela.visible = false
