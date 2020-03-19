extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var canFire = true
var score = 0
var playerScore = 0
var enemiesKilled = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	canFire = true
	
func startGame():
	canFire = true
	score = 0
	playerScore = 0
	enemiesKilled = 0

func newTimer(time, called_from_node, add_as_child_of, callback):
	
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.connect("timeout", called_from_node, callback)
	timer.set_wait_time(time)

	add_as_child_of.add_child(timer)
	
	return timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
