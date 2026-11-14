extends Node


func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene_to_file("res://Scenes/TestScene.tscn")
