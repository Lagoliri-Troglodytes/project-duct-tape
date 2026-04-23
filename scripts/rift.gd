extends Sprite2D
var enemy_scene : PackedScene = preload("res://scenes/entities/enemy.tscn")
var googoo_timer : float = 0.0
func _process(delta: float) -> void:
	var bodies : Array = $Area2D.get_overlapping_bodies()
	for collider in bodies:
		if collider is Player:
			self.texture = load("res://images/rift_closed.png")
	googoo_timer += delta
	if googoo_timer > 8.0:
		var new_enemy : Enemy = enemy_scene.instantiate()
		new_enemy.delete_if_offscreen = true
		new_enemy.position = self.position
		new_enemy.linear_velocity = Vector2(0.0,-600.0).rotated(randf_range(-PI/2.0,PI/2.0))
		self.get_parent().add_child(new_enemy)
		googoo_timer = 0.0
