extends Sprite2D
func _process(delta: float) -> void:
	var bodies : Array = $Area2D.get_overlapping_bodies()
	for collider in bodies:
		if collider is Player:
			self.texture = load("res://images/rift_closed.png")
	
