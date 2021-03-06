extends KinematicBody2D
var move_direction
signal enemy
signal raise_mob_cap
signal lower_mob_cap
signal hide_bullet
var save_data = "user://geoscore.tres"
var team_data = "user://geoteam.tres"
var teamstuff
var upgrade_info

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("raise_mob_cap")
	randomize()
	var move_direction_list = ["down", "diagonal-right-down", "diagonal-left-down"]
	move_direction = move_direction_list[randi() % move_direction_list.size()]
	if ResourceLoader.exists(team_data):
		teamstuff = ResourceLoader.load(team_data)
		if teamstuff.get("team") == "triangle":
			$AnimatedSprite.animation = "enemyhexa"
		else:
			$AnimatedSprite.animation = "enemytri"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ResourceLoader.exists(save_data):
		upgrade_info = ResourceLoader.load(save_data)
		if upgrade_info is score_data:
			print(upgrade_info.get("score"))
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
			emit_signal("lower_mob_cap")
			emit_signal("hide_bullet")
			var upgrade_info = score_data.new()
			upgrade_info.score = upgrade_info.get("score") + 100
			var result = ResourceSaver.save(save_data, upgrade_info)
			assert(result == OK)
			hide()
			queue_free()
		emit_signal("enemy")
		var move_direction_list = ["down", "up", "right", "left", "diagonal-right-down", "diagonal-left-down", "diagonal-right-up", "diagonal-left-up"]
		move_direction = move_direction_list[randi() % move_direction_list.size()] #copied from godot fourms lmao
	velocity = move_and_slide(velocity)
	position += velocity
