extends KinematicBody2D

var movimiento = Vector2()
var velocidad_mov = 200
const gravedad = 10
const UP = Vector2(0, -1)
var fuerza_salto = 180
var doble_salto = false
var tiene_arma = false
const BALA = preload("res://misc/Bala.tscn")

func _physics_process(delta):
	aplicar_gravedad()
	animar_personaje()
	teclas_presionadas()
	move_and_slide(movimiento, UP)

func teclas_presionadas():
	if Input.is_action_pressed("ui_right"):
		movimiento.x = +velocidad_mov
	elif Input.is_action_pressed("ui_left"):
		movimiento.x = -velocidad_mov
	else:
		movimiento.x = 0
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		movimiento.y -= fuerza_salto
		doble_salto = true
	if Input.is_action_just_pressed("disparar") and tiene_arma:
		print("phew phew")
		disparar_bala()

func aplicar_gravedad():
	if !is_on_floor(): movimiento.y += gravedad
	else: movimiento.y = gravedad 

func animar_personaje():
	if movimiento.x < 0 or movimiento.x > 0:
		if !tiene_arma: $AnimatedSprite.play("walking")
		if tiene_arma: $AnimatedSprite.play("walking_gun")
	else:
		if !tiene_arma: $AnimatedSprite.play("idle")
		if tiene_arma: $AnimatedSprite.play("idle_gun")
	if movimiento.x > 0: $AnimatedSprite.flip_h = false
	if movimiento.x < 0: $AnimatedSprite.flip_h = true
	
func tiene_arma(data):
	tiene_arma = data

func disparar_bala():
	var bala = BALA.instance()
	if $AnimatedSprite.flip_h == true: 
		bala.direccion_bala(-1)
		bala.position = $Position2D2.global_position
	else:
		bala.position = $Position2D.global_position
	get_parent().add_child(bala)
	
