extends Area2D

@onready var phil = $"../Player"
@onready var bullet = $"../Bullet"
@onready var test = $"../WhillTest"
var health = 5;
var alive = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if health <= 0:
		alive = false
		hide()
