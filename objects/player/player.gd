extends CharacterBody2D

const SPEED = 25

func _ready():
	$AnimationPlayer.play("RESET_down")

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * SPEED
	move_and_slide()
	
	if velocity.length() > 0:
		var animation: String
		if abs(velocity.x) > abs(velocity.y):
			animation = "walk_side"
			$Sprite2D.set_flip_h(velocity.x < 0)
		elif velocity.y > 0:
			animation = "walk_down"
		else:
			animation = "walk_up"
		$AnimationPlayer.play(animation, -1, SPEED / 11.0)
	else:
		$AnimationPlayer.stop()
	
	var sprite = $Sprite2D
	var half_size = sprite.get_rect().size / 2 * sprite.scale
	var screen_size = get_viewport_rect().size
	global_position.x = clamp(global_position.x, half_size.x, screen_size.x - half_size.x)
	global_position.y = clamp(global_position.y, half_size.y, screen_size.y - half_size.y)
	pass
