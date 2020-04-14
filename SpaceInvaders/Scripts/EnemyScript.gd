extends KinematicBody2D
export(PackedScene) var EnemyMissileScene

var velocity = Vector2()
var shootTimer
var shootChanceMin = 5
var shootChanceMax = 100
var interval = 3.5
var minInterval = 0.2
var missile
var randomTimer
var chance
var left
var right
var moveLeft
var moveDown

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if(not GlobalVariables.cloneChosen):
		shootChanceMin = 25
		interval = 1.5
	left = 0
	right = 0
	moveLeft = true
	moveDown = 0
	randomTimer = RandomNumberGenerator.new()
	shootTimer = GlobalVariables.newTimer(interval, self, self, "shootTimerStopped")
	shootTimer.start()


#func _physics_process(delta):

	# warning-ignore:return_value_discarded
	#move_and_collide(velocity * delta)
	
func missileHit():
	GlobalVariables.score += 10	
	GlobalVariables.enemiesKilled += 1
	if(GlobalVariables.score % 2000 == 0):
		GlobalVariables.lives += 1
		GlobalVariables.playerLives.set_text(str(GlobalVariables.lives))
	GlobalVariables.playerScore.set_text(str(GlobalVariables.score))
	self.queue_free()

func shootTimerStopped():
	randomTimer.randomize()
	chance = randomTimer.randf_range(0, 100.0)
	
	if(chance > shootChanceMax - shootChanceMin):
		missile = EnemyMissileScene.instance()
	
		missile.position.x = self.global_position.x + 19
		missile.position.y = self.global_position.y + 39
	
		missile.add_to_group("missiles")
	
		get_tree().get_root().add_child(missile)
		
	if(moveLeft):
		self.global_position.x -= 15
		left += 1
		right -= 1
		if(left == 9):
			moveLeft = false
			if(moveDown < 11):
				self.global_position.y += 15
				moveDown += 1
	else:
		self.global_position.x += 15
		left -=1
		right += 1
		if(right == 11):
			moveLeft = true
			if(moveDown < 11):
				self.global_position.y += 15
				moveDown += 1
		
	if(shootChanceMin < 85):
		shootChanceMin += 2
	if(interval < minInterval):
		interval /= 1.01
	shootTimer.set_wait_time(interval)
	shootTimer.start()
