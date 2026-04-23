extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	$MainMenuBackground.hide()
	$DuctTapeSprite.hide()
	$CreditsBackground.hide()
	$Title.hide()
	$StartButton.hide()
	$CreditsButton.hide()
	$CreditsCloseButton.hide()
	$CreditsList.hide()
	LevelLoader.load_level("game")
func _on_credits_button_pressed() -> void:
	$Title.text = "Credits"
	$CreditsBackground.show()
	$CreditsCloseButton.show()
	$CreditsList.show()


func _on_credits_close_button_pressed() -> void:
	$Title.text = "Project Duct Tape"
	$CreditsBackground.hide()
	$CreditsCloseButton.hide()
	$CreditsList.hide()
