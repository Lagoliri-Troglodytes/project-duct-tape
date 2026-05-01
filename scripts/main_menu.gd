extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	$CreditsBackground.hide()
	$CreditsCloseButton.hide()
	$CreditsTitle.hide()
	$CreditsList.hide()
	get_tree().change_scene_to_packed(load("res://scenes/level_select.tscn"))

func _on_credits_button_pressed() -> void:
	$Title.hide()
	$CreditsBackground.show()
	$CreditsCloseButton.show()
	$CreditsTitle.show()
	$CreditsList.show()
	$CreditsCloseButton.grab_focus()

func _on_credits_close_button_pressed() -> void:
	$Title.show()
	$CreditsBackground.hide()
	$CreditsCloseButton.hide()
	$CreditsTitle.hide()
	$CreditsList.hide()
	$CreditsButton.grab_focus()
