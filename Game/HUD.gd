extends CanvasLayer

onready var score := 0
onready var scoreNode = $Score

func updateScore():
	score += 1
	scoreNode.text = "Score: " + str(score)

