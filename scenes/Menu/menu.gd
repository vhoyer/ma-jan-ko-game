extends Node2D



func _on_start_button_down():
	$CanvasLayer.visible = false
	add_child(preload("res://scenes/First/First.tscn").instantiate())
	pass
