extends Control

@onready var high_score_label = $HighScoreLabel

func _ready():
	var high_score = FileManager.get_high_score()
	high_score_label.text = "High Score\n" + str(high_score)

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
