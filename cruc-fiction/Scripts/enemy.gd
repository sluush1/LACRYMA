extends Area2D;
@onready var loseLabel = $"../loseLabel";
@onready var restartLabel = $"../restartLabel";

var speed = 80
var direction = 1
var qpressed = false

var level_lost = false
; func _process(delta: float) -> void:
	if level_lost and Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene();
	if not level_lost:
		position.x += speed * direction * delta
		
	if Input.is_key_pressed(KEY_Q):	
		qpressed = true;
		
	if direction > 0 and not $rightCheck.is_colliding() and !qpressed:
		direction = -1
	elif direction < 0 and not $leftCheck.is_colliding():
		direction = 1


func _on_body_entered(body: Node2D) -> void:	
	if body.name == "Player":		
		level_lost = true;		
		loseLabel.visible = true;		
		restartLabel.visible = true;		
		body.set_physics_process(false);
