extends Node2D
var select = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if "map" in i:
			i.map = self 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
