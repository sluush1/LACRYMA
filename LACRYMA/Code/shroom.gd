extends Node2D
@onready var hp = $HPLabel
@onready var sprite = $Sprite2D

const off = 1.1
var nombre = "Shroom";
var attack = randi_range(3,10);
var speed = randi_range(5,9)
var health = 200;
var meter = 0
var stats = []
var playerTurn;
var battle: Node = null;
const HOVER_COLOR := Color(off, off, off, 1.0)
const NORMAL_COLOR := Color(1.0, 1.0, 1.0, 1.0)
var selectable;
var death = false;
var level = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(hp):
		hp.word = health



func _on_area_2d_mouse_entered() -> void:
	if selectable:
		sprite.modulate = HOVER_COLOR



func _on_area_2d_mouse_exited() -> void:
	if battle.currentTurn != self:
		sprite.modulate = NORMAL_COLOR# Replace with function body.

func turn():
	meter = 0;
	hurt(self, battle.phil)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if selectable:
			selectable = false
			battle.targets.append(self)
			battle.idk()
			
func dead():
	if !death:
		hide();
		death = true
		battle.EnemyList.erase(self)
		battle.enemyAmount -= level;
		queue_free()
		if battle.tainer.get_child_count() <= 0:
			battle.win();

func hyde():
	var ftween := create_tween().set_loops();
	ftween.tween_property(self, "modulate:a",0.0,1.0)
	ftween.tween_property(self, "modulate:a", 1.0,1.0)
	
func hurt(attacker, target, stat = null):
	target.health -= attacker.attack;
	attacker.sprite.modulate = Color(1,0.8,0.8,1)
	battle.say(attacker.nombre + " dealt " + str(attacker.attack) + " damage to " + target.nombre)
	await battle.interact
	if stat != null:
		target.stats.append(stat)
		battle.say(target.nombre + " is now " + stat)
		await battle.interact
	attacker.sprite.modulate = Color(1,1,1,1)
	if target.health <= 0:
		battle.say(target.nombre + " is dead")
		target.dead()
		await battle.interact
	battle.endTurn(self);
