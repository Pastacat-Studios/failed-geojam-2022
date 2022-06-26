extends Node2D
export(PackedScene) var bullets
var scorelabel
var save_data = "user://geoscore.tres"
var upgrade_info
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$bulletspawntimer.start()
	scorelabel = RichTextLabel.new()
	add_child(scorelabel)
	scorelabel.rect_global_position = Vector2(554, 36)
	scorelabel.rect_position = $scorepos.global_position
	scorelabel.bbcode_enabled = true
	scorelabel.bbcode_text = "[b]score: 0[/b]"
	scorelabel.text = "help me"
	if ResourceLoader.exists(save_data):
		upgrade_info = ResourceLoader.load(save_data)
		if upgrade_info is score_data:
			print(upgrade_info.get("score"))
			var upgrade_info = score_data.new()
			upgrade_info.score = 0
			var result = ResourceSaver.save(save_data, upgrade_info)
			assert(result == OK)
		else:
			var upgrade_info = score_data.new()
			upgrade_info.score = 0
			var result = ResourceSaver.save(save_data, upgrade_info)
			assert(result == OK)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ResourceLoader.exists(save_data):
		upgrade_info = ResourceLoader.load(save_data)
		if upgrade_info is score_data:
			print(upgrade_info.get("score"))
			scorelabel.bbcode_text = "[b]score: "+str(upgrade_info.get("score"))+"[/b]"


