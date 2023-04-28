extends Area2D

func _ready() -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("Saí da tela!")
	queue_free()
