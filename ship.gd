extends KinematicBody2D
var screen_size
export(PackedScene) var bullets
var shooting
var dead = "false"
var save_data = "user://geosave.tres"
var upgrade_info
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if ResourceLoader.exists(save_data):
		upgrade_info = ResourceLoader.load(save_data)
		if upgrade_info is Upgrade_Data:
			print(upgrade_info.get("upgrade_1_level"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bullet = bullets.instance()
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed("shoot"):
		if dead == "false":
			shooting = "true"
			if upgrade_info is Upgrade_Data:
				if upgrade_info.get("upgrade_1_level") == 1:
					owner.add_child(bullet)
					bullet.transform = $doublebulletspawner1.global_transform
					owner.add_child(bullet)
					bullet.transform = $doublebulletspawner2.global_transform
				else:
					owner.add_child(bullet)
					bullet.transform = $bulletspawner.global_transform
			else:
				owner.add_child(bullet)
				bullet.transform = $bulletspawner.global_transform
	if Input.is_action_just_released("shoot"):
		shooting = "false"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 0.5
	if Input.is_action_pressed("move_right"):
		velocity.x += 0.5
	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.has_signal("enemy"):
			hide()
			dead = "true"
	velocity = move_and_slide(velocity)
	position += velocity
