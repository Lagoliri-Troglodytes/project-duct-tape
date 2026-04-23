extends RigidBody2D
var is_facing_right : bool = true
func _physics_process(delta: float) -> void:
	is_facing_right = self.linear_velocity.x > 0.0
	constant_force = Vector2(250,0.0)
	if is_facing_right:
		$RotationIgnore/RayCastRight.target_position.x = 38.0
		$RotationIgnore/RayCastDown.position.x = 25
	else:
		$RotationIgnore/RayCastRight.target_position.x = -38.0
		$RotationIgnore/RayCastDown.position.x = -25
		constant_force = -constant_force
	$RotationIgnore.global_rotation = 0.0
	$RotationIgnore.global_position = $CollisionShape2D.global_position
	
