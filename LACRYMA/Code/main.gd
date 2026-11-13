extends Node2D
@onready var phil = $"PhilTEST"
@onready var whill = $"WhillTEST"
@onready var attack = $"AttackButton"
@onready var tainer = $"enemyContainer"
@onready var turnLabel = $"turnLabel"
@onready var spawnPoints: Node = $enemySpawn
@export var enemyPrint: PackedScene
var max = 100;
var enemyAmount = 4
var highestSpeed
var EnemyList =[];
var enemyTurn =[]
var mostMeter;
var names_only;
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in spawnPoints.get_child_count():
		var new_enemy = enemyPrint.instantiate()
		new_enemy.name = "enemy" + str(EnemyList.size())
		EnemyList.append(new_enemy) 
		tainer.add_child(new_enemy)
		new_enemy.position = spawnPoints.get_child(i).position
	#turnOrder(1) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("thing"):
		determineMeter()

	
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
	ent.meter = 0
	ent.playerTurn = true
	if ent == phil:
		attack.show()
func _on_attack_button_pressed() -> void:
	attack.hide()
	
func determineMeter() -> void:
	while phil.meter < max or EnemyList.any(func(enemy): return enemy.meter <max):
		phil.meter += phil.speed
		for i in EnemyList.size():
			EnemyList[i].meter += EnemyList[i].speed
	if not EnemyList.any(func(enemy): return enemy.meter >= phil.meter) and phil.meter >= 100:
		turn(phil)
	else:
		for i in EnemyList.size():
			if EnemyList[i].meter >= 100:
				enemyTurn.append(EnemyList[i])
		enemyTurn.shuffle()
		enemyTurn.sort_custom(func(a,b): 
			if a.meter == b.meter:
				return a.speed < b.speed;
			return a.meter > b.meter);
		turn(enemyTurn.pop_front())
