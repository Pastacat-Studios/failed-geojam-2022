extends TextureButton
var save_data = "user://geoteam.tres"
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
		if currentupgradedata is team_data:
			print(currentupgradedata.get("hexagone"))
	var upgrade_info = Upgrade_Data.new()
	upgrade_info.team = "triangle"
	var result = ResourceSaver.save(save_data, upgrade_info)
	assert(result == OK)
