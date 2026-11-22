class_name Upgrade
extends Resource
enum Type{
	MISS_TURN,
	SND,
	HOBO,
	SABRINA_CARPENTER,
	LIN_MANUEL_MIRANDA
	
}

@export var type: Type
@export var title: String
@export_multiline var description: String
@export var value: float = 0.0 # Flexible number (heal amount, multiplier, threshold)
@export var odds: int
