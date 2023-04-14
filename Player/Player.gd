extends KinematicBody2D

export (int) var speed := 200
export (float) var rotation_speed = 1.5

onready var target = position

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
	print(velocity)
	
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

func _physics_process(delta):
	#get_8way_input() # 1. movimento 8 direções
	#get_car_input()  # 2. movimento com giro e avanço/retorno
	#get_mouse_look() # 3. movimento com giro de mouse e teclado
	get_mouse_movement() # 4. movimento com mouse click
	#rotation += rotation_dir * rotation_speed * delta # Usar com 3!
	if position.distance_to(target) > 5: # Usar com o 4!
		velocity = move_and_slide(velocity)
