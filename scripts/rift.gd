extends Sprite2D
var enemy_scene : PackedScene = preload("res://scenes/entities/enemy.tscn")
var googoo_timer : float = 0.0
var googoo_o_clock : float = randf_range(3.0,8.0)
@onready var original_position : Vector2 = self.position
var is_closed : bool = false
func _ready() -> void:
	self.flip_h = randi()%2 == 0
func close_rift() -> void:
	self.texture = load("res://images/rift_closed.png")
	is_closed = true
	# closing animation
	await get_tree().create_timer(randf()*2.0).timeout
	while self.scale.x > 0.05:
		await get_tree().process_frame
		self.scale.x = lerp(self.scale.x, 0.0, get_process_delta_time()*0.3)
		self.scale.y = lerp(self.scale.y, 1.25, get_process_delta_time()*0.3)
	self.queue_free()
func _process(delta: float) -> void:
	if is_closed: return;
	var bodies : Array = $Area2D.get_overlapping_areas()
	for collider in bodies:
		if collider is Tape:
			close_rift()
	googoo_timer += delta
	if googoo_timer > googoo_o_clock:
		self.flip_h = !self.flip_h
		var new_enemy : Enemy = enemy_scene.instantiate()
		new_enemy.delete_if_offscreen = true
		new_enemy.position = self.position
		new_enemy.linear_velocity = Vector2(0.0,-600.0).rotated(randf_range(-PI/2.0,PI/2.0))
		self.get_parent().add_child(new_enemy)
		googoo_o_clock = randf_range(3.0,8.0)
		googoo_timer = 0.0
	self.position.x = original_position.x+sin(PI*pow(googoo_timer/googoo_o_clock*2,4.0))*(googoo_timer/googoo_o_clock)*8
	self.position.y = original_position.y+sin(PI*pow(googoo_timer/googoo_o_clock*7,1.5))*(googoo_timer/googoo_o_clock)*5
