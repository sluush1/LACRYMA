extends CharacterBody2D
@onready var sprite = $"Sprite2D";
@onready var whill = $"../Whill"
@onready var test = $"../BulletTest"
var admin = false
var ded = false
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func death() -> void:
	get_tree().reload_current_scene();

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("R"):
		get_tree().reload_current_scene();
	
	if not is_on_floor() and admin == false:
		velocity += get_gravity() * delta
	
	if ded:
		death();
	
	# Handle jump.
	if Input.is_action_just_pressed("W_up") and is_on_floor():
		if admin == false:
			velocity.y = JUMP_VELOCITY
		else:
			position.y += JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("A_left", "D_right")
	if direction:
		velocity.x = direction * SPEED
		if direction - 1:
			sprite.flip_h = true;
		else:
			sprite.flip_h = false;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	ded = true; # Replace with function body.


func _on_whill_body_entered(body: Node2D) -> void:
	if whill.alive == true:
		ded = true# Replace with function body.
