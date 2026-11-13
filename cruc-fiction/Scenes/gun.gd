extends Sprite2D

@onready var player = $"../Player"
@onready var bullet = $"../Bullet"
var functional = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if functional:
		position.x = player.position.x + 65
		position.y = player.position.y + 100
		look_at(get_global_mouse_position())
		
		if cos(rotation) <= 0:
			flip_v = true
		else:
			flip_v = false
	
