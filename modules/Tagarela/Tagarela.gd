extends CanvasLayer

@onready var dialog = preload("res://dialogs/test.json")

func _ready():
	print_debug(dialog.data)
