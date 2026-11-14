extends Label


#Why Is Godot so diffiCult?
@onready var coin = $"../Coin";
@onready var score_label = $"../ScoreLabel";

var score = 0
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
		
	if coin.visible and position.distance_to(coin.position) < 60:
			coin.hide()
			score += 1
			score_label.text = "Score: " + str(score)
			text = "YOU GOT IT!"
	
	
