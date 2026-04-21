extends Sprite2D
func _ready() -> void:
	var player : Player = get_node("/root/game/Player")
	if player is Player:
		player.position = self.position-Vector2.UP*32
	var player_camera : PlayerCamera = get_node("/root/game/PlayerCamera")
	if player_camera is PlayerCamera:
		player_camera.quick_teleport_to_player()
