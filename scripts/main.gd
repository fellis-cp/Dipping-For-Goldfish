extends Node2D


@export var bug_scene : PackedScene
var score:int = 0
var aux:bool = true


func _process(_delta):
	if score == 10 and aux:
		$BG.texture = load("res://assets/bg1.jpeg")
		$BgMusic.stream = load("res://sounds/FASTER-2020-03-22_-_A_Bit_Of_Hope_-_David_Fesliyan.mp3")
		$BgMusic.play()
		aux = false
		$player.SPEED = 500
		
func game_over():
	$BugTimer.stop()
	$HUD.show_game_over()
	$BgMusic.stop()
	$gameOverSound.play()
	
func new_game():
	$BG.texture = load("res://assets/bg1.jpeg")
	aux = true
	$player.start_pos($StartPosition.position)
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("bugs", "queue_free")
	$BgMusic.stream = load("res://sounds/Slower-Tempo-2020-03-22_-_A_Bit_Of_Hope_-_David_Fesliyan.mp3")
	$BgMusic.play()
	$StartTimer.start()
	

func _on_start_timer_timeout():
	$BugTimer.start()

func _on_bug_timer_timeout():
	var bug = bug_scene.instantiate()
	var bug_location = $BugPath/BugPathLocation
	bug_location.progress_ratio = randf()
	
	var direction = bug_location.rotation + PI / 2
	bug.position = bug_location.position
	direction += randf_range(-PI /4, PI /4)
	bug.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	if score > 10:
		velocity = Vector2(randf_range(150.0, 550.0), 0.0)
	bug.linear_velocity = velocity.rotated(direction)
	add_child(bug)
	if score > 10:
		bug.get_node("./Timer").start()


func _on_player_collected():
	score += 1	
	$HUD.update_score(score)
	$collected.play()
	
