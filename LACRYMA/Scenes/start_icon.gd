extends Sprite2D
var tween := create_tween()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hyde() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func hyde():
	if tween:
		tween.kill()
	
	var tween := create_tween().set_loops();
	tween.tween_property(self, "modulate:a",0.0,1.0)
	tween.tween_property(self, "modulate:a", 1.0,1.0)
	
func jekyll():
	if tween:
		tween.kill()
	modulate.a = 1.0
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
