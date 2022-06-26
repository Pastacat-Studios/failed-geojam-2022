extends Node2D
var save_data = "user://geosave.tres"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var upgrade_info = Upgrade_Data.new()
	upgrade_info.upgrade_1_level = 0
	upgrade_info.upgrade_2_level = 0
	upgrade_info.upgrade_3_level = 0
	upgrade_info.upgrade_4_level = 0
	var result = ResourceSaver.save(save_data, upgrade_info)
	assert(result == OK)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
