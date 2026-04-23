extends RigidBody2D
class_name Enemy
var is_facing_right : bool = true
var delete_if_offscreen : bool = false
var change_direction_timer : float = 0.0
var change_direction_time : float = randf_range(2.0,8.0)
var is_dead : bool = false
@export var jump_velocity = -600
func _ready() -> void:
	self.contact_monitor = true 
	max_contacts_reported = 8
	is_facing_right = self.linear_velocity.x > 0.0
	$RotationIgnore/Sprite2D.play("walking")
func _physics_process(delta: float) -> void:
	self.freeze = !delete_if_offscreen and !$RotationIgnore/VisibleOnScreenNotifier2D.is_on_screen()
	constant_force = Vector2(250,0.0)
	change_direction_timer += delta
	if change_direction_timer > change_direction_time:
		is_facing_right = !is_facing_right
		change_direction_time = randf_range(2.0,8.0)
		change_direction_timer = 0
	elif change_direction_timer > change_direction_time*0.75 or $RotationIgnore/RayCastRight.is_colliding():
		is_facing_right = self.linear_velocity.x > 0.0
	if is_facing_right:
		$RotationIgnore/RayCastRight.target_position.x = 38.0
		$RotationIgnore/RayCastDown.position.x = 64
	else:
		$RotationIgnore/RayCastRight.target_position.x = -38.0
		$RotationIgnore/RayCastDown.position.x = -64
		constant_force = -constant_force
	
	$RotationIgnore.global_rotation = 0.0
	$RotationIgnore.global_position = $CollisionShape2D.global_position+Vector2.UP*12
	$RotationIgnore/Sprite2D.flip_h = is_facing_right
	$RotationIgnore/Sprite2D.speed_scale = abs(self.linear_velocity.x)/250.0
	if $RotationIgnore/Sprite2D.speed_scale < 0.2:
		$RotationIgnore/Sprite2D.frame = 0
	if self.contact_monitor == true:
		for collider in self.get_colliding_bodies():
			if collider is Player:
				if collider.velocity.y >= 0:
					collider.position += Vector2.UP * 8.0
					collider.velocity.y += collider.jump_velocity
					collider.has_jumped = true
			if collider is Enemy:
				if collider.position > self.position+4.0*Vector2.DOWN and self.linear_velocity.y >= 0.0:
					self.linear_velocity += float(jump_velocity)*Vector2.DOWN.rotated(randf_range(-PI/3.0,PI/3.0))
					
	if delete_if_offscreen == true and !$RotationIgnore/VisibleOnScreenNotifier2D.is_on_screen():
		self.queue_free()
