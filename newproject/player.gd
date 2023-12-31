extends Area2D

signal hit

@export var speed = 400 #how fast the player will move (pixels/sec).
var screen_size #stize of the game window.

func _ready(): #_ready is run when node enters a scene tree
	screen_size = get_viewport_rect().size   #gets the size of the viewport

	hide()

func _process(delta):   #_process is checked every frame
	var velocity = Vector2.ZERO #The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) #restricts movement to stay on screen
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_v = false


func _on_body_entered(body):
	hide() #player dissappears after being hit
	hit.emit() #must be deferred as unable to change physics properties on a physics callback
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
