extends Node2D
@onready var phil = $"PhilTEST"
@onready var ttext = $"terminalText"
@onready var attack = $"AttackButton"
@onready var tainer = $"enemyContainer"
@onready var turnLabel = $"turnLabel"
@onready var spawnPoints: Node = $enemySpawn
@export var enemyPrint: PackedScene
var max = 100;
var select = false;
var enemyAmount = 5
var highestSpeed
var EnemyList =[];
var enemyTurn =[]
var mostMeter;
var names_only;
var currentTurn;

signal interact;
		
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
	determineMeter();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
#func turnOrder(x) -> void:
	#max = 100
	#phil.playerTurn = false
	#whill.playerTurn = false;
	#if phil.meter < max and whill.meter <max and x:
		#phil.meter += phil.speed;
		#whill.meter += whill.speed;
	#if phil.meter >= max and not whill.meter >= max:
		#turn(phil)
	#elif whill.meter >= max and not phil.meter >= max:
		#turn(whill)
	#elif phil.meter >= max and whill.meter >= max:
		#if phil.meter > whill.meter:
			#turn(phil)
		#elif phil.meter < whill.meter:
			#turn(whill)
		#else:
			#if phil.speed > whill.speed:
				#turn(phil)
			#elif phil.speed < whill.speed:
				#turn(whill)
			#else: 
				#if randi_range(0,1):
					#turn(phil)
				#else:
					#turn(whill)
	#else:
		#turnOrder(1)

func turn(ent) -> void:
	turnLabel.hide()
	if ent == phil:
		turnLabel.text = "Your turn"
		turnLabel.show()
	currentTurn = ent;
	ent.turn();

func _on_attack_button_pressed() -> void:
	attack.hide()
	ttext.text = "Select your attack target."
	select = true;
	
func determineMeter() -> void:
	enemyTurn.clear()
	while EnemyList.any(func(enemy): return enemy.meter < max):
		for i in EnemyList.size():
			EnemyList[i].meter += EnemyList[i].speed
	for i in EnemyList.size():
		if EnemyList[i].meter >= 100:
			enemyTurn.append(EnemyList[i])
	enemyTurn.shuffle()
	enemyTurn.sort_custom(func(a,b): 
		if a.meter == b.meter:
			return a.speed < b.speed;
		return a.meter > b.meter);
	turn(enemyTurn.pop_front())

func hurt(attacker, target):
	target.health -= attacker.attack;
	say(attacker.nombre + " dealt " + str(attacker.attack) + " damage to " + target.nombre)
	await interact
	if target.health <= 0:
		target.dead()
		say(target.nombre + " is dead")
		await interact
	determineMeter();


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("something"):
		interact.emit()

func say(words):
	ttext.text = words;



#var hovered_ui = get_viewport().gui_get_hovered_control()
	#if hovered_ui:
		#print("UI is blocking mouse: ", hovered_ui.name)
