extends KinematicBody2D
export(PackedScene) var EnemyMissileScene

var velocity = Vector2()
var shootTimer
var shootChanceMin
var shootChanceMax = 100
var interval
var minInterval = 0.2
var missile
var randomTimer
var chance
var left
var right
var moveLeft
var moveDown


# Called when the node enters the scene tree for the first time.
func _ready():
	interval = GlobalVariables.interval
	shootChanceMin = GlobalVariables.shootChanceMin
	left = 0
	right = 0
	moveLeft = true
	moveDown = 0
	randomTimer = RandomNumberGenerator.new()
	shootTimer = GlobalVariables.newTimer(interval, self, self, "shootTimerStopped")
	shootTimer.start()
	
	
func missileHit():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.set_modulate(Color(0, 0, 0, 0))
	var randomVolume = rand_range(-2, 0)
	$ExplosionSound.set_volume_db(randomVolume)
	$ExplosionSound.play()
	GlobalVariables.score += 10	
	GlobalVariables.enemiesKilled += 1
	if(GlobalVariables.score % 2000 == 0):
		GlobalVariables.lives += 1
		GlobalVariables.playerLives.set_text(str(GlobalVariables.lives))
	GlobalVariables.playerScore.set_text(str(GlobalVariables.score))
	
	var t = Timer.new()
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
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
	shootTimer.set_wait_time(interval)
	shootTimer.start()
