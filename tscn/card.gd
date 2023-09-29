extends Area2D

var soup = Vector2.ZERO
var type
var side
var imp
var hp
var att
var rng
var speed
var dir
var sb = Vector2(125,140)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	print("type=" + str(type))
	
	collision_layer = 1 + side
	$det.collision_mask = 2 - side
	
	Global.c[side][soup.y+1].append(self)
	gAdd()
	
	$Spr/Sprite2D.texture = Global.sprites[type]
	imp = Global.cardVarT[type]
	hp = imp[0]
	att = imp[1]
	rng = imp[2]
	speed = imp[3]
	
	goSoup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func goSoup():
	position = Vector2(soup.x-2, soup.y -1) * sb

func move():
	for i in range(0,speed):
		if Global.b[soup.y][soup.x+1*dir] == null: #needs extra cond - no walls
			gDel()
			soup.x += 1*dir
			gAdd()
			goSoup()
			if attack():
				break

func act():
	print("rng is " + str(rng))
	if not attack():
		move()

func attack():
	for i in range(rng):
		print(rng)
		var xFound = soup.x+(1+i)*dir
		if abs(xFound-2) >= 2:
			Global.walls[side].dmg(att)
			print(true)
			return(true)
		else:
			var tar = Global.b[soup.y][xFound]
			if tar != null and tar.side != side:
				tar.dmg(att)
				print(true)
				return(true)
	print(false)
	return(false)
			

func dmg(vdmg):
	hp -= vdmg
	print(str(side) + " " + str(vdmg))
	if hp <= 0:
		var i = 0
		var new_cs = []
		for item in Global.c[side][soup.y]:
			if item != self:
				new_cs.append(item)
#				Global.c[side][soup.y]
#				Global.c[side][soup.y].erase(self)
			Global.c[side][soup.y] = new_cs
			i+=1
		print("ded" + str(Global.c[side][soup.y]))
		gDel()
		print(Global.c[side][soup.y])
		queue_free()

func gAdd():
	Global.b[soup.y][soup.x] = self

func gDel():
	Global.b[soup.y][soup.x] = null


