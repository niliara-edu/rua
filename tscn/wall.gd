extends Area2D

@export var side : int = 0
var hp = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 1+side
	Global.walls[1-side] = self

func dmg(vdmg):
	hp -= vdmg
	print("wall hp: "+str(hp))
	if hp <= 0:
		Global.walls[1-side]=null
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.

func anima():
	pass
