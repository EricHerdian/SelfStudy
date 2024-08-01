extends CharacterBody2D

@export var item_picked_sound: AudioStream

@onready var animation = $AnimatedSprite2D
@onready var sound = $AudioStreamPlayer2D

const SPEED = 300.0
const JUMP_VELOCITY = -350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var held_item = null

func _ready():
	sound.stream = item_picked_sound

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			animation.play("Fall")

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction == 1:
		animation.flip_h = false
	elif direction == -1:
		animation.flip_h = true
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation.play("Idle")
	
	move_and_slide()

func _on_item_picked():
	sound.play()
