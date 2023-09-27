extends Node

var sprites = [null]
var file = FileAccess.open("res://data/cardValues.txt", FileAccess.READ)

var c = [[ [],[],[] ],[ [],[],[] ]]

signal done

var can = true



var cardVars = {
	"hp" : 0,
	"att" : 1,
	"range" : 2,
	"speed" : 3,
}

const defaults = [1, 1, 1, 1]


var cardVarT = [null]

func _ready():
	
	for i in range(1,3):
		cardVarT.append([])
		sprites.append(load("res://exp/" + str(i) + ".png"))
		var line : String = file.get_line()
		var l = line.split("	")
		
		for x in l.size():
			var res = (l[x].split("="))
			if res.size() > 1 and res[1] != "def":
				cardVarT[i].append(int(res[1]))
			else:
				cardVarT[i].append(defaults[x])


func mCards(side):
	if can:
		can = false
		for i in range(0, 3):
			var x = c[side][i].size()
			for r in range(0,x):
				c[side][i][r].act()
		can = true
			#c[side][i][x-r-1].act()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

