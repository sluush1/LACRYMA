extends CharacterBody2D
@onready var loseLabel = $"../loseLabel";
@onready var restartLabel = $"../restartLabel";

var level_lost = false
func _process(delta: float) -> void:
	if level_lost and Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene();
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = -SPEED
	move_and_slide()

const SPEED = 800





func _on_ouch_box_body_entered(body: Node2D) -> void:
	if body.name == "Player":		
		level_lost = true;		
		loseLabel.visible = true;		
		restartLabel.visible = true;		
		body.set_physics_process(false);
