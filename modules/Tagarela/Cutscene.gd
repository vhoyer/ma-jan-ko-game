extends CanvasLayer

signal finished

func _ready():
	visible = true
	$AnimationPlayer.play("story")

func _on_animation_player_animation_finished(anim_name):
	finished.emit()
	call_deferred("free")
