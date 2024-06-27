extends CanvasLayer

signal start_game
@onready var score_label = $Control/ScoreLabel
@onready var message_label = $Control/MessageLabel
@onready var start_button = $Control/StartButton
@onready var message_timer = $MessageTimer	
@onready var virtual_joystick = $"Control/Test/UI/Virtual joystick left"


func _ready(): 
	virtual_joystick.visible = false

func show_message(text):
	message_label.text = text
	message_label.show()
	message_timer.start()
	virtual_joystick.visible = false
	
func show_game_over():
	show_message("Game Over")
	await message_timer.timeout
	
	message_label.text = "Dipping for Goldfish"
	message_label.show()
	
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(score):
	score_label.text = str(score)
	
func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()
	virtual_joystick.visible = true
	
func _on_message_timer_timeout():
	message_label.hide()
	

	

	
 
	
