extends Area2D

@onready var gun = $"../Gun"
@onready var phil = $"../Player"
@onready var funnyShootyCollisionDetecty = $"CollisionShape2D"
@onready var whill = $"../Whill"
@onready var test = $"../BulletTest"

var inrange = true
var speed = 700
var shoot = false
var spinnyGo;
var functional = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if functional == true:
		funnyShootyCollisionDetecty.position = position
			
		if shoot == true:
			position.y += sin(spinnyGo) * delta * speed
			position.x += cos(spinnyGo) * delta * speed
			funnyShootyCollisionDetecty.position = position
			if abs(position.x - whill.position.x) == 100 and abs(position.y - whill.position.y) == 100:
				test.text = "true"
			else:
				test.text = "fasle"
		else:
			hide()
		
		if Input.is_action_just_pressed("click"):
			inrange = true
			position.x = gun.position.x - 160
			position.y = gun.position.y - 90
			shoot = true
			spinnyGo = gun.rotation
			show()
		
	
	


func _on_whill_area_entered(area: Area2D) -> void:
	if whill.alive == true:
		whill.health -= 1
		shoot = false
