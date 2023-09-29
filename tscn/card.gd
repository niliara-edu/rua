extends Area2D

var soup = Vector2.ZERO
var tween
var tar
var blocked = false

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
	
	position=goSoup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func goSoup():
#	position = Vector2(soup.x-2, soup.y -1) * sb
	return(Vector2(soup.x-2, soup.y -1) * sb)

func move():
	for i in range(0,speed):
		if Global.b[soup.y][soup.x+1*dir] == null:
			gDel()
			soup.x += 1*dir
			gAdd()
			if attack():
				aMove()
				aAttack()
				break
	aMove()

func aMove():
	tween.tween_property(self, "position", goSoup(), 0.2)

func aAttack():
	tween.tween_callback(tcomplete)
	tween.tween_property(self, "position", goSoup() + Vector2(50, 0)*dir, 0.1)
	tween.tween_interval(0.05)
	tween.tween_property(self, "position", goSoup(), 0.1)
	
	

func tcomplete():
	if is_instance_valid(tar):
		tar.anima()

func anima():
	if hp <= 0 and not blocked:
		tween = null
		tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		blocked = true
		
		tween.tween_property(self, "position", goSoup()-Vector2(50*dir,0),0.6)
		tween.tween_property(self, "modulate", Color(1,1,1,0),0.6)
		
		tween.set_parallel(false)
		tween.tween_callback(queue_free)
	


func act():
	if blocked:
		return(0)
	tween = null
	tween = create_tween().set_parallel(false).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	if attack():
		aAttack()
	else:
		move()

func attack():
	for i in range(rng):
		var xFound = soup.x+(1+i)*dir
		if abs(xFound-2) >= 2:
			tar = Global.walls[side]
			if tar != null and tar.side != side:
				tar.dmg(att)
			return(true)
		else:
			tar = Global.b[soup.y][xFound]
			if tar != null and tar.side != side:
				tar.dmg(att)
				return(true)
	return(false)
			

func dmg(vdmg):
	hp -= vdmg
	if hp <= 0:
		var new_cs = []
		for item in Global.c[side][soup.y]:
			if item != self:
				new_cs.append(item)
			Global.c[side][soup.y] = new_cs
		gDel()
#		queue_free()

func gAdd():
	Global.b[soup.y][soup.x] = self

func gDel():
	Global.b[soup.y][soup.x] = null


