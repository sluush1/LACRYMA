extends Button
var battle;
var button;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	


func _on_pressed() -> void:
	battle.togButtons(true)
	battle.ttext.text = "Select your attack targets."
	battle.hurt(battle.phil.attack * .5, 3)
