extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

const SPEED = 60

var direction = 1

func _process(delta):
	if ray_cast_right.is_colliding():
		animated_sprite_2d.flip_h = true
		direction = -1
	if ray_cast_left.is_colliding():
		animated_sprite_2d.flip_h = false
		direction = 1
	position.x += direction * SPEED * delta
