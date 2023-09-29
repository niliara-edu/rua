extends Node2D
@onready var cLoad = load("res://tscn/card.tscn")

var t = 1

func _ready():
	cNew(0,0,t)
	cNew(1,0,t)




#### PROCESS ####

func _process(_delta):
	if Input.is_action_just_pressed("1"):
		cMove(0)
	if Input.is_action_just_pressed("2"):
		cMove(1)
	if Input.is_action_just_pressed("3"):
		cNew(0,0,t)
	if Input.is_action_just_pressed("4"):
		cNew(1,0,t)




#### CARD RELATED FUNCTIONS ####

func cNew(side, row, type):
	if Global.b[row+1][side*4] != null:
		return(false)
	var cInstance = cLoad.instantiate()
	cInstance.side = side
	cInstance.type = randi_range(1,Global.currentCards)
	cInstance.dir = 1 - side*2
	
	cInstance.soup = Vector2(4*side, row+1)
	$Cards.add_child(cInstance)


func cMove(side):
	Global.mCards(side)
