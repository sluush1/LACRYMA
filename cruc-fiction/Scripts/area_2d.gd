extends Area2D;
@onready var loseLabel = $"../loseLabel";
@onready var restartLabel = $"../restartLabel";
@onready var player = $"../Player";
var level_lost = false; func _process(delta: float) -> void:	if level_lost and Input.is_key_pressed(KEY_R):	get_tree().reload_current_scene();

func _on_body_entered(body: Node2D) -> void:
		if body.name == "Player":
			Global.death();
