extends Node

var sprites = [null]
var file = FileAccess.open("res://data/cardValues.txt", FileAccess.READ)

class CardType:
	var name : String
	var hp : int
	var dmg : int
	var range : int = 1
	var speed : int = 1

func _ready():
	for i in range(1,10):
		sprites.append(load("res://exp/" + str(i) + ".png"))
		var line : String = file.get_line()
		var l = line.split(", ")
		print(l)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
