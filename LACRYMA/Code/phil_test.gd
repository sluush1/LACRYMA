extends Sprite2D

@onready var button = $"../basicButton"
@onready var hp = $"../philHP"

var speed = 10;
var health = 200;
var meter = 0;
var attack = 500;
var battle;
var nombre = "Phil"

var playerTurn;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hp.text = str(health);
	
func turn():
	meter = 0;
	battle.ttext.text = ""
	button.show()
	
func dead():
	battle.ttext.text = "You Lose!"
