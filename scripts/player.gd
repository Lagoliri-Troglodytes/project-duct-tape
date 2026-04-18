extends CharacterBody2D
class_name Player

@export var speed = 400
@export var jump_velocity = -400
var screen_size

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 

func ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if not is_on_floor():
			velocity.y += gravity
			
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += jump_velocity
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	move_and_slide()
