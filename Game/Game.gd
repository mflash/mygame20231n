extends Node2D

var sceneLimit : Position2D
var player : KinematicBody2D

var currentScene = null

func _ready() -> void:
	currentScene = get_child(0) # pega o Level1, etc
	sceneLimit = currentScene.get_node("SceneLimit")
	player = currentScene.get_node("Player")
	
func _physics_process(delta: float) -> void:
	
	if sceneLimit == null:
		return
		
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene("res://GameOver.tscn")
		
	if Input.is_key_pressed(KEY_X):
		call_deferred("goto_scene", "res://GameOver.tscn")
		
	if Input.is_action_just_pressed("music"):
		print("Music!")
		var effect : AudioEffectLowPassFilter = AudioServer.get_bus_effect(1,0)
		if effect.cutoff_hz == 500:
			effect.cutoff_hz = 20000
		else:
			effect.cutoff_hz = 500
	
func goto_scene(path: String):
	print("Total children: "+str(get_child_count()))
	var world := get_child(0)
	world.free()
	var res := ResourceLoader.load(path)
	currentScene = res.instance()
	sceneLimit = null
	get_tree().get_root().add_child(currentScene)
	#self.add_child(currentScene)
