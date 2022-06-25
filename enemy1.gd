extends KinematicBody2D
var move_direction
signal enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
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
		emit_signal("enemy")
		var move_direction_list = ["down", "up", "right", "left", "diagonal-right-down", "diagonal-left-down", "diagonal-right-up", "diagonal-left-up"]
		move_direction = move_direction_list[randi() % move_direction_list.size()] #copied from godot fourms lmao
	velocity = move_and_slide(velocity)
	position += velocity
