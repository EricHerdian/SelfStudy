extends Control

@onready var heartUIEmpty = $HeartUIEmpty
@onready var heartUIFFull = $HeartUIFull

var max_heart = 4: set = set_max_heart
var heart = 4: set = set_heart

func set_max_heart(value):
	max_heart = max(value, 1)
	if heartUIEmpty != null:
		heartUIEmpty.size.x = max_heart * 15

func set_heart(value):
	heart = clamp(value, 0, max_heart)
	if heartUIFFull != null:
		heartUIFFull.size.x = heart * 15

func _ready():
	scale = scale * 5
	self.max_heart = PlayerStats.max_health
	self.heart = PlayerStats.health
	PlayerStats.connect("health_changed", Callable(self, "set_heart"))
	PlayerStats.connect("max_health_changed", Callable(self, "set_max_heart"))
