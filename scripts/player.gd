extends CharacterBody2D
class_name Player

@export var speed = 400
@export var jump_velocity = -400
var has_jumped = true
@export var max_health : int = 3
var health : int = max_health

@onready var coyote_timer = $CoyoteTimer

var screen_size

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 

func ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta: float) -> void:
	velocity.x = 0
	
	if not is_on_floor():
		velocity.y += gravity * delta
		coyote_timer.start()
		has_jumped = true


	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("jump"):
		jump()
	if Input.is_action_pressed("attack"):
		pass
		
	if abs(velocity.x) > 0:
		velocity.x *= speed
		#$AnimatedSprite2D.play()
	#else:
		#$AnimatedSprite2D.stop()
	if is_on_floor() == false:
		if $AnimatedSprite2D.animation != "falling":
			$AnimatedSprite2D.animation = "falling"
			$AnimatedSprite2D.play()
			if $AnimatedSprite2D.frame == 1:
				$AnimatedSprite2D.stop()
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walking"
		if !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play()
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.x == 0:
		if $AnimatedSprite2D.animation != "default":
			$AnimatedSprite2D.animation = "idle"
			$AnimatedSprite2D.stop()
		if randf() < 0.5*delta and !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.animation = "default"
			$AnimatedSprite2D.play()
	move_and_slide()
	
	
func jump():
	if is_on_floor() or !coyote_timer.is_stopped() and !has_jumped:
		velocity.y += jump_velocity
		has_jumped = false
	
