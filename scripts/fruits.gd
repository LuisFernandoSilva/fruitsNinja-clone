extends RigidBody2D

onready var collisionShape = get_node("collisionShape")
onready var sprite0 = get_node("sprite0")
onready var body1 = get_node("body1")
onready var sprite1 = get_node("body1/sprite1")
onready var body2 = get_node("body2")
onready var sprite2 = get_node("body2/sprite2")

var cut = false
signal score
signal life


func _ready():
	
	randomize()
	set_process(true)
	
	

func _process(delta):
	if get_pos().y > 800:
		emit_signal("life")
		queue_free()
	if body1.get_pos().y > 800 and body2.get_pos().y > 800:
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
	if cut: return 
	cut = true 
	emit_signal("score")
	set_mode(MODE_KINEMATIC)# faz o corpo da pear ficar parado
	sprite0.queue_free()
	collisionShape.queue_free()
	body1.set_mode(MODE_RIGID)
	body2.set_mode(MODE_RIGID)
	body1.apply_impulse(Vector2(0,0), Vector2(-100,0).rotate(get_rot())) #funcao pede dois vetors um p offset e outro pra a direçao do impulso
	body2.apply_impulse(Vector2(0,0), Vector2(100,0).rotate(get_rot()))
	body1.set_angular_velocity(get_angular_velocity()) #pega a velocidade d rotaçao do objeto inicial
	body2.set_angular_velocity(get_angular_velocity())
	
	
	
	 