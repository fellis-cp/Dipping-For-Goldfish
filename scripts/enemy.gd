extends RigidBody2D


@onready var anim = $anim


func _ready():
	var enemy_types = anim.sprite_frames.get_animation_names()
	anim.play(enemy_types[randi() % enemy_types.size()])


func _on_visible_screen_exited():
	queue_free()
	

func _on_timer_timeout():
	var enemy_types = anim.sprite_frames.get_animation_names()
	anim.play(enemy_types[randi() % enemy_types.size()]) # Replace with function body.
	$Timer.start()
	
