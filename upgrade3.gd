extends TextureButton
var save_data = "user://geosave.tres"
var currentupgradedata
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	if ResourceLoader.exists(save_data):
		currentupgradedata = ResourceLoader.load(save_data)
		if currentupgradedata is Upgrade_Data:
			print(currentupgradedata.get("upgrade_3_level"))
	var upgrade_info = Upgrade_Data.new()
	upgrade_info.upgrade_3_level = 1
	upgrade_info.upgrade_2_level = currentupgradedata.get("upgrade_2_level")
	upgrade_info.upgrade_1_level = currentupgradedata.get("upgrade_1_level")
	upgrade_info.upgrade_4_level = currentupgradedata.get("upgrade_4_level")
	var result = ResourceSaver.save(save_data, upgrade_info)
	assert(result == OK)
