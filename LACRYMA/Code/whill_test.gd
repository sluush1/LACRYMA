extends Node2D
@onready var hp = $HPLabel
@onready var sprite = $Sprite2D

var Name;
var damage = 10;
var speed = randi_range(0,30)
var health = 200;
var meter = 0
var playerTurn;
const HOVER_COLOR := Color(2, 2, 2, 1.0)
const NORMAL_COLOR := Color(1.0, 1.0, 1.0, 1.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(hp):
		hp.word = health

	
func hurt(amt) -> void:
	health -= amt
	if health <= 0:
		hide()
		
func attack(target):
	target.health -= damage;


func _on_area_2d_mouse_entered() -> void:
	sprite.modulate = HOVER_COLOR



func _on_area_2d_mouse_exited() -> void:
	sprite.modulate = NORMAL_COLOR# Replace with function body.
