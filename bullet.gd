extends KinematicBody2D
signal aplayerbullet

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	velocity.y -= 0.5
	var collision = move_and_collide(velocity)
	if collision:
		emit_signal("aplayerbullet")
	velocity = move_and_slide(velocity)
	position += velocity

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
