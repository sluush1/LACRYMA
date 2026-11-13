extends Node2D

@onready var restartLabel = $"restartLabel"
@onready var loselabel = $"loseLabel";

func death() -> void:
	restartLabel.visible = true;
	loselabel.visible = true;
	get_tree().paused = true
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
