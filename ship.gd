extends KinematicBody2D
var screen_size
export(PackedScene) var bullets
export(PackedScene) var bullets2
var shooting
var dead = "false"
var save_data = "user://geosave.tres"
var team_data = "user://geoteam.tres"
var upgrade_info
var teamstuff
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
	if ResourceLoader.exists(team_data):
		teamstuff = ResourceLoader.load(team_data)
		if teamstuff.get("team") == "triangle":
			$AnimatedSprite.animation = "playertri"
		else:
			$AnimatedSprite.animation = "playerhexa"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bullet = bullets.instance()
	var bullet2 = bullets2.instance()
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed("shoot"):
		if dead == "false":
			shooting = "true"
			if upgrade_info is Upgrade_Data:
				if upgrade_info.get("upgrade_1_level") == 1:
					owner.add_child(bullet)
					bullet.transform = $doublebulletspawner1.global_transform
					owner.add_child(bullet2)
					bullet2.transform = $doublebulletspawner2.global_transform
				else:
					owner.add_child(bullet)
					bullet.transform = $bulletspawner.global_transform
			else:
				owner.add_child(bullet)
				bullet.transform = $bulletspawner.global_transform
	if Input.is_action_just_released("shoot"):
		if upgrade_info.get("upgrade_3_level") == 1:
			shooting = "false"
		else:
			$shootcooldown.start()
	if Input.is_action_pressed("move_left"):
		velocity.x -= 0.5 + upgrade_info.get("upgrade_2_level") / 2
	if Input.is_action_pressed("move_right"):
		velocity.x += 0.5 + upgrade_info.get("upgrade_2_level") / 2
	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.has_signal("enemy"):
			hide()
			dead = "true"
			get_tree().change_scene("res://upgrade-selection.tscn")
	velocity = move_and_slide(velocity)
	position += velocity



func _on_shootcooldown_timeout():
	shooting = "false"
	$shootcooldown.stop()
