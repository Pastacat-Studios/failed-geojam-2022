extends KinematicBody2D
var screen_size
export(PackedScene) var bullets
var shooting
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bullet = bullets.instance()
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed("shoot"):
		shooting = "true"
		#var bulletvelocity = Vector2.ZERO
		#bulletvelocity.y = $bulletspawner.position.y
		#bulletvelocity.x = $bulletspawner.position.x
		owner.add_child(bullet)
		bullet.transform = $bulletspawner.global_transform
	if Input.is_action_just_released("shoot"):
		shooting = "false"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 0.5
	if Input.is_action_pressed("move_right"):
		velocity.x += 0.5
	velocity = move_and_slide(velocity)
	position += velocity
