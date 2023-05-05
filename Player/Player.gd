extends KinematicBody2D

export (int) var speed := 200
export (float) var rotation_speed = 1.5

export (float) var gravity = 3000
export (float) var jump_speed = 1000
export (PackedScene) var box : PackedScene

onready var target = position
onready var sprite = $Sprite
onready var jumpSound = $JumpSound
onready var shootSound = $ShootSound

var velocity = Vector2.ZERO
var rotation_dir = 0

func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		
func get_8way_input():
	#velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")	
	velocity.y = Input.get_action_strength("down")-Input.get_action_strength("up")
	velocity = velocity.normalized() * speed
	#print(velocity)
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.play("down")
		sprite.stop()
		sprite.frame = 0
	
func get_car_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	rotation_dir = Input.get_action_strength("right")-Input.get_action_strength("left")
	if Input.is_action_pressed("down"):
		velocity = Vector2(0,speed).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(0,-speed).rotated(rotation)
		
func get_mouse_look():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	velocity = Vector2.ZERO
	if Input.is_action_pressed("down"):
		velocity = Vector2(0,speed).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(0,-speed).rotated(rotation)
		
func get_mouse_movement():
	velocity = position.direction_to(target) * speed
	
func get_side_input():
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
	velocity.x *= speed
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.frame = 0
		
	if Input.is_key_pressed(KEY_S):
		#if not shootSound.playing:
		shootSound.play()
		
	if is_on_floor() and Input.is_action_just_pressed('jump'):
		jumpSound.play()
		velocity.y = -jump_speed
		get_tree().call_group("HUD", "updateScore")
		var b := box.instance()
		b.position = global_position
		owner.add_child(b)

func _physics_process(delta):
	#get_8way_input() # 1. movimento 8 direções
	#get_car_input()  # 2. movimento com giro e avanço/retorno
	#get_mouse_look() # 3. movimento com giro de mouse e teclado
	#get_mouse_movement() # 4. movimento com mouse click
	#rotation += rotation_dir * rotation_speed * delta # Usar com 3!
	#if position.distance_to(target) > 5: # Usar com o 4!
	velocity.y += gravity * delta
	get_side_input()
	velocity = move_and_slide(velocity, Vector2.UP)
	#if position.y > 900:
	#	get_tree().change_scene("res://GameOver.tscn")
