extends Camera2D
class_name PlayerCamera
@onready var player : Player = self.get_node("../Player")

var camera_speed : float = 12.0
func quick_teleport_to_player() -> void:
	check_player_exists()
	self.global_position = player.global_position
func _process(delta: float) -> void:
	check_player_exists()
	self.global_position = lerp(
		self.global_position,
		player.global_position,
		clamp(camera_speed*delta,0.0,1.0))
func check_player_exists():
	assert((player is Player),"PlayerCamera can not find valid player!!")
