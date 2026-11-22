extends Sprite2D
var twen := create_tween()
var map

@export var battle: PackedScene
@export var count: int = 9;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hyde() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func hyde():
	if twen:
		twen.kill()
	
	var twen := create_tween().set_loops();
	twen.tween_property(self, "modulate:a",0.0,1.0)
	twen.tween_property(self, "modulate:a", 1.0,1.0)
	
func jekyll():
	if twen:
		twen.kill()
	modulate.a = 1.0
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Manage.fight(battle,count)
