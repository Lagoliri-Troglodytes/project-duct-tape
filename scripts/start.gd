extends Sprite2D
class_name Start
var is_driving_away : bool = false
@onready var amount_of_rifts : int:
	get():
		if get_parent().is_node_ready() == false:
			return -1
		var total : int = 0
		for r in self.get_parent().get_children():
			if r is Rift and !r.is_closed:
				total += 1
		return total
func _ready() -> void:
	var player : Player = get_node("/root/game/Player")
	if player is Player:
		player.position = self.position-Vector2.UP*32
	var player_camera : PlayerCamera = get_node("/root/game/PlayerCamera")
	if player_camera is PlayerCamera:
		player_camera.quick_teleport_to_player()
func _init() -> void:
	print(self.name)
func collect_rift():
	amount_of_rifts -= 1
func add_rift():
	amount_of_rifts += 1
func _physics_process(_delta: float) -> void:
	if amount_of_rifts < 1 and amount_of_rifts != -1:
		for collider in $Area2D.get_overlapping_bodies():
			if collider is Player:
				collider.win()
				collider.position = self.position
				drive_away()
func drive_away():
	if is_driving_away: return;
	is_driving_away = true
	while $VisibleOnScreenNotifier2D.is_on_screen():
		self.position+=Vector2.LEFT*self.get_process_delta_time()*300
		await get_tree().process_frame
	LevelLoader.load_level("level_2")
	#LevelLoader.return_to_menu()
