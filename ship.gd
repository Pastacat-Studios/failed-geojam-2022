extends KinematicBody2D
var screen_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bullet = bullet.instance()
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 0.5
	if Input.is_action_pressed("move_right"):
		velocity.x += 0.5
	velocity = move_and_slide(velocity)
	position += velocity
