extends Node2D
@onready var phil = $"PhilTEST"
@onready var ttext = $"terminalText"
@onready var attack = $"basicButton"
@onready var tainer = $"enemyContainer"
@onready var turnLabel = $"turnLabel"
@onready var spawnPoints: Node = $enemySpawn
@export var enemyPrint: PackedScene
var mx = 100;
var select = false;
var enemyAmount = 9
var highestSpeed
var EnemyList =[];
var enemyTurn =[]
var targets = [];
var mostMeter;
var names_only;
var currentTurn;
var level = 1;

signal interact;
signal selected;
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ttext.text = "";
	for i in enemyAmount:
		var new_enemy = enemyPrint.instantiate()
		new_enemy.name = new_enemy.nombre + str(EnemyList.size())
		EnemyList.append(new_enemy) 
		tainer.add_child(new_enemy)
		new_enemy.battle = self;
		new_enemy.position = spawnPoints.get_child(i).position
	for child in get_children():
		if "battle" in child:
			child.battle = self
	EnemyList.append(phil);
	determineMeter()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func turn(ent) -> void:
	turnLabel.hide()
	if ent == phil:
		turnLabel.text = "Your turn"
		turnLabel.show()
	currentTurn = ent;
	ent.turn();

func _on_basic_button_pressed() -> void:
	attack.hide()
	ttext.text = "Select your attack target."
	select = true;
	
func determineMeter() -> void:
	enemyTurn.clear()
	while EnemyList.any(func(enemy): return enemy.meter < mx):
		for i in EnemyList.size():
			EnemyList[i].meter += EnemyList[i].speed
	for i in EnemyList.size():
		if EnemyList[i].meter >= mx:
			enemyTurn.append(EnemyList[i])
	enemyTurn.shuffle()
	enemyTurn.sort_custom(func(a,b): 
		if a.meter == b.meter:
			return a.speed < b.speed;
		return a.meter > b.meter);
	turn(enemyTurn.pop_front())

func hurt(attacker, target):
	target.health -= attacker.attack;
	if attacker != phil:
		attacker.sprite.modulate = Color(1,0.8,0.8,1)
	say(attacker.nombre + " dealt " + str(attacker.attack) + " damage to " + target.nombre)
	await interact
	if attacker != phil:
		attacker.sprite.modulate = Color(1,1,1,1)
	if target.health <= 0:
		say(target.nombre + " is dead")
		target.dead()
		await interact
	if enemyAmount > 0 and phil.health > 0:
		determineMeter();
	
func multihurt(atk, amount, _stat):
	setvar("selectable", true)
	for i in amount:
		await selected
	setvar("selectable", false)
	for i in targets.size():
		targets[i].health -= atk
		say("phil dealt " + str(atk) + " damage to " + targets[i].nombre)
		await interact
		if targets[i].health <= 0:
			say(targets[i].nombre + " is dead")
			targets[i].dead()
			await interact
		if enemyAmount > 0 and phil.health > 0:
			determineMeter();


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("something"):
		interact.emit()

func say(words):
	ttext.text = words;

func win():
	turnLabel.hide()
	ttext.text = "You Win!"
	attack.hide()
	await interact
	Manage.stopFighting()
	
func setvar(vb,value):
	for i in tainer.get_children():
		i.set(vb, value)

func idk():
	selected.emit()
