extends Node

var restartlabel
var loselabel

func death() -> void:
	#restartlabel.visible = true;
	#loselabel.visible = true;
	#await get_tree().create_timer(1.0).timeout
	get_tree().paused = true
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
