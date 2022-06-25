extends KinematicBody2D
var move_direction
signal enemy
signal raise_mob_cap
signal lower_mob_cop

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("raise_mob_cap")
	randomize()
	var move_direction_list = ["down", "diagonal-right-down", "diagonal-left-down"]
	move_direction = move_direction_list[randi() % move_direction_list.size()]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	match move_direction:
		"down":
			velocity.y += 0.5
		"up":
			velocity.y -= 0.5
		"right":
			velocity.x -= 0.5
		"left":
			velocity.x += 0.5
		"diagonal-right-down":
			velocity.x -= 0.5
			velocity.y += 0.5
		"diagonal-left-down":
			velocity.x += 0.5
			velocity.y += 0.5
		"diagonal-right-up":
			velocity.x -= 0.5
			velocity.y -= 0.5
		"diagonal-left-up":
			velocity.x += 0.5
			velocity.y -= 0.5
	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.has_signal("aplayerbullet"):
			emit_signal("lower_mob_cop")
			hide()
			queue_free()
		emit_signal("enemy")
		var move_direction_list = ["down", "up", "right", "left", "diagonal-right-down", "diagonal-left-down", "diagonal-right-up", "diagonal-left-up"]
		move_direction = move_direction_list[randi() % move_direction_list.size()] #copied from godot fourms lmao
	velocity = move_and_slide(velocity)
	position += velocity
