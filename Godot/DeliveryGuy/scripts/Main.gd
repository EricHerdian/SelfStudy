extends Node2D

@export var npc_count = 4
@export var time_limit = 60
@export var npcs_scene = []
@export var spawn_points = []

@onready var player = $Player
@onready var pickup_zone = $ItemPickupZone
@onready var gui = $Interface
@onready var timer = $Timer

var score = 0
var time_left = time_limit

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(npc_count):
		# Set item list in pickup zone
		pickup_zone.item_list.append(i)
		
		# Generate NPC and it's location
		var npc_scene = npcs_scene[randi_range(0, npcs_scene.size() - 1)]
		var npc_instance = npc_scene.instantiate()
		var spawn_point = spawn_points[i]
		var random_point = Vector2(
			randf_range(spawn_point[0].x, spawn_point[1].x),
			randf_range(spawn_point[0].y, spawn_point[1].y)
		)
		npc_instance.position = random_point
		npc_instance.connect("item_get", Callable(self, "_on_item_delivered"))
		
		# Set NPC needed item
		npc_instance.item_needed = i
		
		# Spawn NPC
		add_child(npc_instance)
	
	# Connect Signals
	pickup_zone.connect("item_picked", Callable(player, "_on_item_picked"))
	
	# Set Timer
	_update_timer_label()

# Counting score and update the view
func _on_item_delivered():
	score += 1
	gui.set_score(score)

# Counting time left and update the view
func _on_timer_timeout():
	time_left -= 1
	
	_update_timer_label()
	
	# TIME OUT
	if time_left <= 0:
		timer.stop()
		_handle_game_over()

func _handle_game_over():
	FileManager.set_high_score(score)
	FileManager.save_data()
	gui.game_over_menu()

# Update Timer View
func _update_timer_label():
	gui.set_timer(time_left)
