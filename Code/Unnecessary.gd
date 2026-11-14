extends Label
@onready var whill = $"../WhillTEST"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(whill.health)

#var hovered_ui = get_viewport().gui_get_hovered_control()
	#if hovered_ui:
		#print("UI is blocking mouse: ", hovered_ui.name)


	
#func turnOrder(x) -> void:
	#max = 100
	#phil.playerTurn = false
	#whill.playerTurn = false;
	#if phil.meter < max and whill.meter <max and x:
		#phil.meter += phil.speed;
		#whill.meter += whill.speed;
	#if phil.meter >= max and not whill.meter >= max:
		#turn(phil)
	#elif whill.meter >= max and not phil.meter >= max:
		#turn(whill)
	#elif phil.meter >= max and whill.meter >= max:
		#if phil.meter > whill.meter:
			#turn(phil)
		#elif phil.meter < whill.meter:
			#turn(whill)
		#else:
			#if phil.speed > whill.speed:
				#turn(phil)
			#elif phil.speed < whill.speed:
				#turn(whill)
			#else: 
				#if randi_range(0,1):
					#turn(phil)
				#else:
					#turn(whill)
	#else:
		#turnOrder(1)
