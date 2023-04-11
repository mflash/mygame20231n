extends Node2D

const SPEED := 300

var total : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(total)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(delta)
	total += delta
	update_score(total)
	
func _physics_process(delta: float) -> void:
	#print(delta)
	#total += delta
	#update_score(total)
	# Polling deve ser usado sempre que for
	# preciso fazer leitura CONTÍNUA de entradas
	if Input.is_action_pressed("ui_right"):
		position.x += SPEED * delta

func _input(event: InputEvent) -> void:
	print(event.as_text())
	# Só usar em situações onde a leitura contínua
	# não é necessária (ex: uma tecla para abrir um menu)
	#if event.is_action_pressed("ui_right"):
	#	position.x += SPEED/100
	

	
func update_score(current_score: float) -> void:
	$Score.text = str(current_score)
	
