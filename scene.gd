extends Node2D
@onready var cLoad = load("res://tscn/card.tscn")

var turn = 0
var tween

func _ready():
	pass




#### PROCESS ####

func _process(_delta):
	if Input.is_action_just_pressed("1"):
		cNew(turn,0,1)
	if Input.is_action_just_pressed("2"):
		cNew(turn,1,1)
	if Input.is_action_just_pressed("3"):
		cNew(turn,2,1)
	if Input.is_action_just_pressed("passTurn"):
		passTurn()

func passTurn():
	cMove(turn)
	turn = 1-turn
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Camera2D,"position",Vector2(20*turn + 20*(turn-1),0),0.5)
	


#### CARD RELATED FUNCTIONS ####

func cNew(side, row, type):
	if Global.b[row][side*4] != null:
		return(false)
	var cInstance = cLoad.instantiate()
	cInstance.side = side
	cInstance.type = randi_range(1,Global.currentCards)
	cInstance.dir = 1 - side*2
	
	cInstance.soup = Vector2(4*side, row)
	$Cards.add_child(cInstance)


func cMove(side):
	Global.mCards(side)
