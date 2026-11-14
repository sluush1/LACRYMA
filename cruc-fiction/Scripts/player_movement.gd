extends Label

@onready var goal = $"../Goal"
#Why Is Godot so diffiCult?



var speed = 250

func _process(delta):
	if Input.is_key_pressed(KEY_RIGHT):
		position.x += speed * delta

	if Input.is_key_pressed(KEY_LEFT):
		position.x -= speed * delta

	if Input.is_key_pressed(KEY_DOWN):
		position.y += speed * delta

	if Input.is_key_pressed(KEY_UP):
		position.y -= speed * delta
	
	if abs(position.x - goal.position.x) < 150 and abs(position.y - goal.position.y) < 50:
		text = "you win!"
