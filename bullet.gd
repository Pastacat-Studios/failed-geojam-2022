extends KinematicBody2D
signal aplayerbullet
var save_data = "user://geosave.tres"
var upgrade_info

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if ResourceLoader.exists(save_data):
		upgrade_info = ResourceLoader.load(save_data)
		if upgrade_info is Upgrade_Data:
			print(upgrade_info.get("upgrade_1_level"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	velocity.y -= 0.5
	var collision = move_and_collide(velocity)
	if collision:
		emit_signal("aplayerbullet")
		if collision.collider.has_signal("hide_bullet"):
			if upgrade_info.get("upgrade_4_level") == 1:
				pass
			else:
				hide()
				queue_free()
	velocity = move_and_slide(velocity)
	position += velocity

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
