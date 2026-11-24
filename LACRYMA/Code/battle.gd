extends Node2D
@onready var phil = $"PhilTEST"
@onready var ttext = $"terminalText"
@onready var attack = $"basicButton"
@onready var tainer = $"enemyContainer"
@onready var turnLabel = $"turnLabel"
@onready var skill1 = $"skill1"
@onready var spawnPoints: Node = $enemySpawn

@export var mush: PackedScene
@export var shroom: PackedScene
@export var pho: PackedScene


@export var upgrades: Array[Upgrade] = []
@export var buttonPrint: Button;
var jekyll : Tween;
var mx = 100;
var select = false;
var enemyAmount = 9
var highestSpeed
var EnemyList =[];
var enemyTurn =[]
var targets = [];
var skills = [];
var mostMeter;
var names_only;
var currentTurn;
var level = 1;
var q = 0
var qi = 0

var burned = Color(1.0, 0.647, 0.0, 1.0)
var vitalized = Color(0,1,0,1)

signal interact;
signal selected;
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	togButtons(true)
	var list = [shroom,mush,pho,shroom,mush,pho,mush,pho,shroom]
	ttext.text = "";
	while q < enemyAmount:
		var new_enemy = list[randi_range(0,list.size()-q-1)].instantiate()
		new_enemy.name = new_enemy.nombre + str(EnemyList.size())
		EnemyList.append(new_enemy) 
		tainer.add_child(new_enemy)
		new_enemy.battle = self;
		new_enemy.position = spawnPoints.get_child(qi).position
		q += new_enemy.level
		qi += 1
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
	currentTurn = ent;
	ent.turn();

func _on_basic_button_pressed() -> void:
	togButtons(true)
	ttext.text = "Select your attack target."
	hurt(phil.attack, 1)
	
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


	
func hurt(atk, amount: int, stat = null):
	atk = roundi(atk)
	setvar("selectable", true)
	hyde()
	if tainer.get_child_count() >= amount:
		for i in amount:
			await selected
	else:
		for i in tainer.get_child_count():
			await selected
	setvar("selectable", false)
	syke()
	for i in targets.size():
		targets[i].health -= atk
		say("phil dealt " + str(atk) + " damage to " + targets[i].nombre)
		await interact
		if targets[i].health <= 0:
			say(targets[i].nombre + " is dead")
			dead(targets[i])
			await interact
		elif stat != null:
			targets[i].stats.append(stat)
			say(targets[i].nombre + " is " + stat)
			statcolor(stat, targets[i]);
			await interact
	targets.clear()
	endTurn(currentTurn)



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("something"):
		interact.emit()

func say(words):
	ttext.text = words;

func win():
	turnLabel.hide()
	ttext.text = "You Win!"
	togButtons(true)
	await interact
	Manage.stopFighting()
	
func setvar(vb,value):
	for i in tainer.get_children():
		i.set(vb, value)

func idk():
	selected.emit()
	
func hyde():
	if jekyll:
		jekyll.kill()
	jekyll = create_tween().set_loops()
	jekyll.tween_method(hydePotion, 1.0, 0.0 ,1)
	jekyll.tween_method(hydePotion, 0.0, 1.0, 1)

func hydePotion(slurp: float):
	for i in targets:
		if is_instance_valid(i):
			i.sprite.modulate.a = slurp;

func syke():
	if jekyll:
		jekyll.kill()
	hydePotion(1.0)
	
func togButtons(h):
	for i in get_children():
		if "button" in i:
			if h:
				i.hide()
			else:
				i.show()
func statcolor(stat, target):
	target.hp.add_theme_color_override("font_color", get(stat))

func endTurn(ent):
	var change = randi_range(10,100)
	if ent.stats.has("burned"):
		ent.health -= change;
		say(ent.nombre + " took " + str(change) + " damage from burned")
		await interact
		if ent.health <= 0:
			say(ent.nombre + " is dead.")
			dead(ent)
			await interact
	if is_instance_valid(ent):
		if ent.stats.has("vitalized"):
			ent.health += change
			say(ent.nombre + " healed " + str(change) + " from vitalized")
			await interact
		if tainer.get_child_count() > 0 and phil.health > 0:
			determineMeter()
func upgrade(new_upgrade: Upgrade):
	upgrades.append(new_upgrade)
	
func addSkill():
	pass
	
func dead(ent):
	if ent == phil:
		phil.dead()
	else:
		EnemyList.erase(ent)
		ent.queue_free()
		if tainer.get_child_count()-1 <= 0:
			win();
#func await and or var class in true false null self signal const self enum 
#int String bool Node Node2D Node3D float PackedScene Array Button Label Color ColorRect Sprite2D Marker2D 
