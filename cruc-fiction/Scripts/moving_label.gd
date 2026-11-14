extends Label

var speed = 400

var xbinary = 0
var ybinary = 0

func _process(delta):
	if position.x <= -575:
		xbinary = 0
	if position.x >= 400:
		xbinary = 1
		
	if xbinary == 0:
		position.x += speed * delta
	if xbinary ==1:
		position.x -= speed * delta
