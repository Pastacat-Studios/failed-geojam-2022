extends KinematicBody2D
var moving_right = "false"
export(PackedScene) var mobs
var mobcap = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	if mobcap != 10:
		var mob = mobs.instance()
		owner.add_child(mob)
		mob.position = position


func _on_enemy1_raise_mob_cap():
	mobcap += 1


func _on_enemy1_lower_mob_cap():
	mobcap -= 1
