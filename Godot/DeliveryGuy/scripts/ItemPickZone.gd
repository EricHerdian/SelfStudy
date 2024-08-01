extends Area2D

@onready var particle = $CPUParticles2D

var item_list = []
signal item_picked

func _on_body_entered(body):
	if body.name == "Player" && body.held_item == null:
		body.held_item = item_list[randi_range(0, item_list.size() - 1)]
		print("Item Picked")
		emit_signal("item_picked")
