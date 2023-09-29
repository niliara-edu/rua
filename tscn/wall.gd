extends Area2D

@export var side : int = 0
var hp = 20

func _ready():
	collision_layer = 1+side
	Global.walls[1-side] = self



#### RESPONSES ####

func dmg(vdmg):
	hp -= vdmg
	print("wall hp: "+str(hp))
	if hp <= 0:
		Global.walls[1-side]=null
		queue_free()

func anima():
	pass

