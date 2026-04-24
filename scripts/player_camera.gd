extends Camera2D
class_name PlayerCamera
@onready var player : Player = self.get_node("../Player")

var camera_speed : float = 6.0
var camera_offset : Vector2 = Vector2(0.0,-0.125)
func quick_teleport_to_player() -> void:
	check_player_exists()
	var screen_size : Vector2 = self.get_viewport_rect().size
	self.global_position = player.global_position+camera_offset*screen_size
func _process(delta: float) -> void:
	check_player_exists()
	
	$Clock/Hand.rotation = -player.time_left/player.level_time*2.0*PI
	var clock_text : String = str(int(player.time_left/60))+":"+str(int(player.time_left)%60)
	if int(player.time_left)%60 < 10: clock_text = clock_text.left(-1)+"0"+clock_text.right(1);
	$Clock/DigitalElement.text = clock_text
	for h in $Clock/Hearts.get_children().size():
		var heart : Sprite2D = $Clock/Hearts.get_children()[h]
		if player.health > h:
			heart.offset = lerp(heart.offset,-player.get_real_velocity()*0.05*cos(PI*3.0*player.time_left+h*PI*0.5)+8.0*Vector2.UP*sin(PI*player.time_left+h*PI*0.5),delta*0.5)
		else:
			heart.texture = load("res://images/heart_lost.png")
			heart.offset = lerp(heart.offset,Vector2.ZERO,delta*2.0)
	
	if player.is_dead: return;
	var screen_size : Vector2 = self.get_viewport_rect().size
	var player_vel_influence : Vector2 = player.get_real_velocity()*0.22
	player_vel_influence.x = clamp(
		player_vel_influence.x,
		-screen_size.x*0.5,
		screen_size.x*0.5)
	player_vel_influence.y = clamp(
		player_vel_influence.y,
		-screen_size.y*0.5,
		screen_size.y*0.5)
	self.global_position = lerp(
		self.global_position,
		player.global_position+player_vel_influence+camera_offset*screen_size,
		clamp(camera_speed*delta,0.0,1.0))
func check_player_exists():
	assert((player is Player),"PlayerCamera can not find valid player!!")
