extends Node2D

onready var intervalTimer = get_node("intervalTimer")
onready var limitTimer = get_node("limitTimer")

var pressed = false # pra saber se estamos pressionando a tela
var drag = false # pra saber se estamos arrastando o dedo na tela
var currentPosition = Vector2(0,0)
var oldPosition = Vector2(0,0)


func _ready():
	
	set_process_input(true)
	set_fixed_process(true) #ativa os processos com a biblioteca de fisica

func _fixed_process(delta):
	update()
	if drag and currentPosition != oldPosition and oldPosition != Vector2(0,0):
		#para cria os arraycast setas dinamicas pela tela
		#chama uma funcao despacial 2d do mundo e a direçao que isto esta
		var space_state = get_world_2d().get_direct_space_state()
		#cria um raio que vai da antiga a atual posiçao
		var result = space_state.intersect_ray(oldPosition,currentPosition)
		#se o resultado nao estiver vazio encontrou algo no caminho
		if not result.empty():
			result.collider.cut()


func _input(event):
	event = make_input_local(event) # define que os eventos de input permaneçao conforme a tela local
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			print("pressed")
			pressed(event.pos)
		else:
			print("realesed")
			released()
	elif event.type == InputEvent.SCREEN_DRAG:
		drag(event.pos)
		
func pressed(pos):
	print("pressed")
	pressed = true
	oldPosition = pos
	intervalTimer.start()
	limitTimer.start()
	
func released():
	pressed = false 
	drag = false
	intervalTimer.stop()
	limitTimer.stop()
	oldPosition = Vector2(0,0)
	currentPosition = Vector2(0,0)

func drag(pos):
	currentPosition = pos
	drag = true
	print("drag")
	

func _on_intervalTimer_timeout():
	oldPosition = currentPosition

func _on_limitTimer_timeout():
	released()

func _draw():
	if drag and currentPosition != oldPosition and oldPosition != Vector2(0,0):
		draw_line(currentPosition, oldPosition, Color(1,0,0), 10)


