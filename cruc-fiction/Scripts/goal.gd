extends Area2D;

@onready var test = $"../BulletTest"
@onready var gun = $"../Gun"
@onready var bullet = $"../Bullet"

var levelComplete = false;

func _process(delta: float) -> void:
	if levelComplete and Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene();

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		levelComplete = true;
		gun.functional = false
		bullet.functional = false
		test.text = "You Win!"
		test.show()
		body.set_physics_process(false);
