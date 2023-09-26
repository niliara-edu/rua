extends Area2D

var type = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Spr/Sprite2D.texture = Global.sprites[type]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
