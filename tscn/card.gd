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
	$RayCast2D2.collision_mask = 1 + side
	$det.collision_mask = 2 - side
	$RayCast2D.collision_mask = 2 - side
	
	Global.c[side][soup.y+1].append(self)
	
	$Spr/Sprite2D.texture = Global.sprites[type]
	imp = Global.cardVarT[type]
	hp = imp[0]
	att = imp[1]
	rng = imp[2]
	speed = imp[3]
	
	$RayCast2D.target_position.x = rng * sb.x * dir
	$RayCast2D2.target_position.x = sb.x * dir
	
	goSoup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func goSoup():
	position = soup * sb

func move():
	for i in range(0,speed):
		$RayCast2D2.force_raycast_update()
		if not $RayCast2D2.is_colliding() or $RayCast2D2.get_collider().soup.x*dir > soup.x*dir+1:
			soup.x += 1*dir
			goSoup()
			if attack():
				break
		else:
			break
		

func act():
	if not attack():
		move()

func attack():
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		$RayCast2D.get_collider().dmg(att)
		return(true)
	else:
		return(false)

func dmg(vdmg):
	hp -= vdmg
	if hp <= 0:
		var i = 0
		for item in Global.c[side][soup.y+1]:
			if item == self:
				Global.c[side][soup.y+1].remove_at(i)
			i+=1
		queue_free()
