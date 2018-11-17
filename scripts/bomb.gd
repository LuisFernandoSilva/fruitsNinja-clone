extends RigidBody2D

onready var shape = get_node("shape")
onready var sprite = get_node("sprite")
onready var animation = get_node("animation")

signal life
var cutter = false

func _ready():
	set_process(true)
	randomize()

func _process(delta):
	if get_pos().y > 800:
		queue_free()

func born(initPos):
	set_pos(initPos)
	var initSpeed = Vector2(0, rand_range(-1000, -800))# no y para que va para cima
	if initPos.x < 640:
		initSpeed = initSpeed.rotated(deg2rad(rand_range(0,-30)))#se sair da tela joga na tela em diagonal
	else:
		initSpeed = initSpeed.rotated(deg2rad(rand_range(0,30)))
	
	set_linear_velocity(initSpeed)
	set_angular_velocity(rand_range(-10, 10))
	
func cut():
	if cutter:
		return 
	cutter = true
	emit_signal("life")
	set_mode(MODE_KINEMATIC)
	animation.play("explode")
	
