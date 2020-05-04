extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var canFire = true
var score = 0
var playerScore = 0
var enemiesKilled = 0
var lives = 2
var playerLives = 2
var playerDead = false
var cloneChosen = false
var barrierArray = []
var player = null
var missileLifeTime = 3.0
var shootChanceMin = 20
var missileChanceMin = 10
var interval = 1.25

# Called when the node enters the scene tree for the first time.
func _ready():
	canFire = true
	
func startGame():
	canFire = true
	score = 0
	playerScore = 0
	enemiesKilled = 0
	lives = 2
	playerLives = 2
	playerDead = false
	barrierArray = []
	shootChanceMin = 20
	missileChanceMin = 10
	interval = 1.26
	

func newTimer(time, called_from_node, add_as_child_of, callback):
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.connect("timeout", called_from_node, callback)
	timer.set_wait_time(time)

	add_as_child_of.add_child(timer)
	
	return timer
	
func barrierRestore():
	print(barrierArray.size())
	for barrier in barrierArray:
		barrier.respawnBarrier()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
