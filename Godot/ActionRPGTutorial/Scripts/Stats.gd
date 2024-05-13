extends Node

signal no_health
signal health_changed(value)
signal max_health_changed(value)

#var health = max_health: # Setter Getter
	#get:
		#return health
	#set(value):
		#health = value
		#emit_signal("health_changed", health)
		#if health <= 0:
			#emit_signal("no_health")

@export var max_health = 1: set = set_max_health # Setter Getter Alternative

var health = max_health: set = set_heath # Setter Getter Alternative

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_heath(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func _ready():
	self.health = max_health
