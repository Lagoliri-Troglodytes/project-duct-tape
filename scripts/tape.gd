extends Area2D
class_name Tape
@export var attack_cooldown : float = 0.1
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
		$Sprite2D.flip_h = $"../AnimatedSprite2D".flip_h

func attack() -> void:
	if is_on_cooldown:
		return
	$Sprite2D.stop()
	$Sprite2D.play("default")
	is_on_cooldown = true
	visible = true
	await get_tree().create_timer(0.08).timeout
	$attack_hitbox.disabled = false
	await get_tree().create_timer(0.2).timeout
	$attack_hitbox.disabled = true
	await get_tree().create_timer(0.1).timeout
	visible = false
	await get_tree().create_timer(attack_cooldown).timeout
	is_on_cooldown = false
