extends TextureButton
var save_data = "user://geosave.tres"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if ResourceLoader.exists(save_data):
		var upgrade_info = ResourceLoader.load(save_data)
		if upgrade_info is Upgrade_Data:
			print(upgrade_info.get("upgrade_1_level"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	var upgrade_info = Upgrade_Data.new()
	upgrade_info.upgrade_1_level += 1
	var result = ResourceSaver.save(save_data, upgrade_info)
	assert(result == OK)
