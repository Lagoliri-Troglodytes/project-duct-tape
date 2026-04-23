extends Area2D
class_name Tape
@export var attack_cooldown : float = 0.1
@export var attack_length : float = 0.1
var is_on_cooldown : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$attack_hitbox.disabled = true
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()
	if !is_on_cooldown:
		if $"../AnimatedSprite2D".flip_h:
			self.position.x = -88.0+32
		else:
			self.position.x = 88.0-32

func attack() -> void:
	if is_on_cooldown:
		return
	is_on_cooldown = true
	$attack_hitbox.disabled = false
	visible = true
	await get_tree().create_timer(attack_length).timeout
	$attack_hitbox.disabled = true
	visible = false
	await get_tree().create_timer(attack_cooldown).timeout
	is_on_cooldown = false
