extends CanvasLayer

signal start_game
@onready var score_label = $Control/ScoreLabel
@onready var message_label = $Control/MessageLabel
@onready var start_button = $Control/StartButton
@onready var message_timer = $MessageTimer


func show_message(text):
	message_label.text = text
	message_label.show()
	message_timer.start()
	
func show_game_over():
	show_message("Game Over")
	await message_timer.timeout
	
	message_label.text = "Catch The Golden Bugs"
	message_label.show()
	
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(score):
	score_label.text = str(score)
	
func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()
	
func _on_message_timer_timeout():
	message_label.hide()
