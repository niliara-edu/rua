extends Node

var file = FileAccess.open("res://data/cData", FileAccess.READ)

var cardVarT = [null] # Card Variable Types (in order)
var sprites = [null] # Sprite files

const defaults = [1, 1, 1, 1] # Default Card Variables

var c = [[ [],[],[] ],[ [],[],[] ]] # cards in order
var b = [[null,null,null,null,null],
[null,null,null,null,null],
[null,null,null,null,null]] # board matrix
var walls = [null, null] #walls

var deck = []

#### temporary ####
const currentCards = 9


func _ready():
	for i in range(1,currentCards+1):
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
	
	for i in range(1,currentCards+1):
		deck.append(i)
	deck.shuffle()
	print(deck)


func mCards(side):
	for i in range(0, 3):
		var x = c[side][i].size()
		for r in range(0,x):
			if is_instance_valid(c[side][i][r]):
				c[side][i][r].act()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

