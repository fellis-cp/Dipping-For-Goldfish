extends Area2D

signal collected
signal hit
var SPEED := 400 
var screen_size
@onready var collision = $collision
@onready var anim = $anim


func _ready():
	screen_size = get_viewport_rect().size - get_viewport_rect().size*0.06
	screen_size.y += 16
	hide()

func _process(delta):
	var velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED

	if velocity.x != 0:
		anim.play("move")
	elif velocity.y > 0:
		anim.play("move_up")
	elif velocity.y < 0:
		anim.play("move_down")
	else:
		anim.play("idle")
		
	anim.flip_h = true if velocity.x > 0 else false
	
	position += velocity * delta
	position = position.clamp(Vector2(30, 30), screen_size)

func _on_body_entered(body):
	if body.anim.get_animation() == "yellow_beetle":
		collected.emit()
		body.queue_free()
		return
	else: 
		hide()
		hit.emit()
		collision.set_deferred("disabled", true)

func start_pos(pos):
	position = pos
	show()
	collision.disabled = false
