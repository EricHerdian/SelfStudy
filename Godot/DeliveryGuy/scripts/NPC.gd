extends CharacterBody2D

@export var delivered_sound: AudioStream

@onready var sound = $AudioStreamPlayer2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var item_needed = null
signal item_get

func _ready():
	sound.stream = delivered_sound

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.name == "Player" && body.held_item == item_needed:
		body.held_item = null
		sound.play()
		emit_signal("item_get")
