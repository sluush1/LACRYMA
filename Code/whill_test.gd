extends Node2D
@onready var hp = $HPLabel
@onready var sprite = $Sprite2D

const off = 1.1
var nombre = "Shroom";
var attack = randi_range(3,10);
var speed = randi_range(5,9)
var health = 200;
var meter = 0
var playerTurn;
var battle: Node = null;
const HOVER_COLOR := Color(off, off, off, 1.0)
const NORMAL_COLOR := Color(1.0, 1.0, 1.0, 1.0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(hp):
		hp.word = health



func _on_area_2d_mouse_entered() -> void:
	if battle.select:
		sprite.modulate = HOVER_COLOR



func _on_area_2d_mouse_exited() -> void:
	sprite.modulate = NORMAL_COLOR# Replace with function body.

func turn():
	meter = 0;
	battle.hurt(self, battle.phil)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if battle.select:
			battle.hurt(battle.phil, self)
			sprite.modulate = NORMAL_COLOR
			battle.select = false;
			
func dead():
	hide();
	battle.EnemyList.erase(self)
	battle.enemyAmount -= 1;
	if battle.enemyAmount <= 0:
		battle.win();
