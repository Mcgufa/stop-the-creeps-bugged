extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names() #gets the names of animations in an array
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])  #picks a random number from the array and plays the animation

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
