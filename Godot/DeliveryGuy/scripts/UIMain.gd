extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var timer_label = $TimerLabel
@onready var game_menu_panel = $GameMenuPanel
@onready var menu_title = $GameMenuPanel/Panel/Title
@onready var menu_button = $MenuButton
@onready var continue_button = $GameMenuPanel/Panel/VBoxContainer/ContinueButton
@onready var exit_button = $GameMenuPanel/Panel/VBoxContainer/ExitButton

func _ready():
	game_menu_panel.set_visible(false)

func set_score(score: int):
	score_label.text = "Score: " + str(score)

func set_timer(time_left: int):
	var minutes = int(time_left / 60)
	var seconds = int(time_left % 60)
	
	timer_label.text = "Time\n" + str("%0*d" % [2, minutes]) + ":" + str("%0*d" % [2, seconds])

func _on_menu_button_pressed():
	Engine.time_scale = 0
	menu_title.text = "Game Paused"
	game_menu_panel.set_visible(true)

func _on_continue_button_pressed():
	Engine.time_scale = 1
	game_menu_panel.set_visible(false)

func _on_exit_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func game_over_menu():
	Engine.time_scale = 0
	menu_title.text = "Game Over"
	game_menu_panel.set_visible(true)
	continue_button.set_visible(false)
