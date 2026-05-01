extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level1Button.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/main_menu.tscn"))

func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/game.tscn")) # i'm hesitant to rename the game scene to level 1 cause i don't know if it'll break anything

func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/level_2.tscn"))

func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/level_3.tscn"))

func _on_level_4_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/level_4.tscn"))

func _on_level_5_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/level_5.tscn"))

func _on_super_secret_level_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/super_secret_level.tscn"))
