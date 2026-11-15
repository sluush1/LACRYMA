extends Node

var world: Node = null;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func fight(battle: PackedScene, amt: int):
	var tree = get_tree();
	world = tree.current_scene
	tree.root.remove_child(world)
	var battle_instance = battle.instantiate()
	battle_instance.enemyAmount = amt
	tree.root.add_child(battle_instance)
	tree.current_scene = battle_instance

func stopFighting():
	if world == null:
		return
		
	var tree = get_tree()
	tree.current_scene.queue_free()
	tree.root.add_child(world)
	tree.current_scene = world
	world = null
