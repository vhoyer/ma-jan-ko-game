extends CharacterBody2D

const SPEED = 25
@export var contain_in_viewport: bool = false
@export var pixel_perfect_movement: bool = true

func _ready():
	$AnimationPlayer.play("RESET_down")

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = direction * SPEED
	var old = position
	move_and_slide()
	
	if pixel_perfect_movement and velocity and !is_on_wall():
		# https://www.reddit.com/r/godot/comments/cvn6qn/ive_figured_out_a_way_to_smooth_out_jittery/?utm_source=share&utm_medium=android_app&utm_name=androidcss&utm_term=3&utm_content=1
		if abs(old.x - position.x) > abs(old.y - position.y):
			var x = round(position.x)
			var y = round(position.y + (x - position.x) * velocity.y / velocity.x)
			position.y = y
		else:
			var y = round(position.y)
			var x = round(position.x + (y - position.y) * velocity.x / velocity.y)
			position.x = x
	
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
	
	if (contain_in_viewport):
		var sprite = $Sprite2D
		var half_size = sprite.get_rect().size / 2 * sprite.scale
		var screen_size = get_viewport_rect().size
		global_position.x = clamp(global_position.x, half_size.x, screen_size.x - half_size.x)
		global_position.y = clamp(global_position.y, half_size.y, screen_size.y - half_size.y)
	
	pass
