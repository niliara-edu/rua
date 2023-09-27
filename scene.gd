extends Node2D
@onready var cLoad = load("res://tscn/card.tscn")

var t = 1

func _ready():
	cNew(0,0,t)
	cNew(1,0,t)

func _process(_delta):
	if Input.is_action_just_pressed("0"):
		cMove(0)
	if Input.is_action_just_pressed("1"):
		cMove(1)
	if Input.is_action_just_pressed("2"):
		cNew(0,0,t)
	if Input.is_action_just_pressed("3"):
		cNew(1,0,t)

func cNew(side, row, type):
	var cInstance = cLoad.instantiate()
	cInstance.side = side
	cInstance.type = type
	if side == 0:
		cInstance.dir = 1
	else:
		cInstance.dir = -1
	
	cInstance.soup = Vector2(4*side-2, row)
	$Cards.add_child(cInstance)

func cMove(side):
	Global.mCards(side)
