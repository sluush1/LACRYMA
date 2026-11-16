extends Sprite2D
var tween := create_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func hyde():
	var tween := create_tween();
	tween.tween_property(self, "modulate:a",0.0,1.0)
	tween.tween_callback(queue_free)
	
func jekyll():
	var tween := create_tween()
	
