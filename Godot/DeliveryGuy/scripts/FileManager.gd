extends Node

var high_score = 0
var file_path = "user://high_score.save"

func _ready():
	load_data()

func set_high_score(score: int):
	if score > high_score:
		high_score = score

func get_high_score():
	return high_score

func save_data():
	var save_dict = {
		"high_score": high_score
	}
	
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var json = JSON.new()
	var json_string = json.stringify(save_dict)
	file.store_string(json_string)
	file.close()

func load_data():
	if not FileAccess.file_exists(file_path):
		return
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var data = json.parse_string(json_string)
	set_high_score(data["high_score"])
