extends CharacterBody2D

@export var ACCELERATION = 300
@export var FRICTION = 200
@export var MAX_SPEED = 50
@export var WANDER_TARGET_RANGE = 4

@onready var stats = $Stats
@onready var sprite = $AnimatedSprite2D
@onready var animationPlayer = $AnimationPlayer
@onready var softCollision = $SoftCollision
@onready var hurtbox = $Hurtbox
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var wanderController = $WanderController

const DeathEffect = preload("res://Scenes/EnemyDeathEffect.tscn")

enum{
	IDLE,
	WANDER,
	CHASE
}

var state = IDLE

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			
			accelerate_toward_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_toward_point(player.global_position, delta)
			else:
				state = IDLE
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	
	move_and_slide()

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(randi_range(1, 3))

func accelerate_toward_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	velocity = area.knockback_vector * 120
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)

func _on_stats_no_health():
	var deathEffect = DeathEffect.instantiate()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position
	queue_free()

func _on_hurtbox_invincibility_started():
	animationPlayer.play("Start")

func _on_hurtbox_invincibility_ended():
	animationPlayer.play("Stop")
