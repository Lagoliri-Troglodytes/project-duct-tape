extends Node
var level : String = "game"
func load_level(l : String = level):
	level = l
	if !level.is_valid_filename(): return;
	var file_path : String = "res://scenes/"+level+".tscn"
	if !FileAccess.file_exists(file_path): return;
	get_tree().change_scene_to_packed(load(file_path))
func return_to_menu():
	get_tree().change_scene_to_packed(load("res://scenes/level_select.tscn"))
