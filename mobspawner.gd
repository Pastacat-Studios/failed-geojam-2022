extends KinematicBody2D
var moving_right = "false"
export(PackedScene) var mobs
export(PackedScene) var boss
var mobcap = 0
var save_data = "user://geoscore.tres"
var upgrade_info

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ResourceLoader.exists(save_data):
		upgrade_info = ResourceLoader.load(save_data)
		if upgrade_info is score_data:
			print(upgrade_info.get("score"))
	if upgrade_info.get("score") == 5000:
		var bossed = boss.instance()
		owner.add_child(bossed)
		bossed.position = position
	var velocity = Vector2.ZERO
	if moving_right == "true":
		velocity.x -= 0.03
	else:
		velocity.x += 0.03
	var collision = move_and_collide(velocity)
	if collision:
		if moving_right == "true":
			moving_right = "false"
		else:
			moving_right = "true"
	velocity = move_and_slide(velocity)
	position += velocity
	
func _on_bulletspawntimer_timeout():
	if upgrade_info.get("score") < 5000:
		var mob = mobs.instance()
		owner.add_child(mob)
		mob.position = position


func _on_enemy1_raise_mob_cap():
	mobcap += 1


func _on_enemy1_lower_mob_cap():
	mobcap -= 1
