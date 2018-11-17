extends Node2D

onready var fruits = get_node("fruits")

var pear = preload("res://scenes/pear.tscn")
var orange = preload("res://scenes/orange.tscn")
var avocado = preload("res://scenes/avocado.tscn")
var banana = preload("res://scenes/banana.tscn")
var lemon = preload("res://scenes/lemon.tscn")
var pineapple = preload("res://scenes/pineapple.tscn")
var watermelon = preload("res://scenes/watermelon.tscn")
var tomato = preload("res://scenes/tomato.tscn")
var bomb = preload("res://scenes/bomb.tscn")

var score = 0
var life = 3


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_generator_timeout():
	if life <= 0:
		return 
	for i in range(0, rand_range(1,2)):# faz o for de quantas frutas vai aparecer na tela
		var type = int(rand_range(0,9))#faz o randomico do tipo
		var obj
		if type == 0:
			obj = pear.instance()
		elif type == 1:
			obj = orange.instance()
		elif type == 2:
			obj = avocado .instance()
		elif type == 3:
			obj = banana.instance()
		elif type == 4:
			obj = lemon.instance()
		elif type == 5:
			obj = pineapple.instance()
		elif type == 6:
			obj = watermelon.instance()
		elif type == 7:
			obj = tomato.instance()
		elif type == 8:
			obj = bomb.instance()
		
		obj.born(Vector2(rand_range(200,1080),800))
		obj.connect("life", self, "dec_life")
		if type !=8:
			obj.connect("score", self, "inc_score")
		
		fruits.add_child(obj)

func dec_life():
	life -= 1
	if life == 2:
		get_node("control/bomb3").set_modulate(Color(1,0,0))
	elif life == 1:
		get_node("control/bomb2").set_modulate(Color(1,0,0))
	elif life == 0:
		get_node("gameOver").start()
		get_node("control/bomb1").set_modulate(Color(1,0,0))
		get_node("inputProcess").over = true 
	
	
func inc_score():
	if life == 0:
		return 
	
	score += 1
	get_node("control/score").set_text(str(score))
	