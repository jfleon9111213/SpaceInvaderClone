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
var health
var invincibleTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	shootChanceMin = GlobalVariables.shootChanceMin
	interval = GlobalVariables.interval
	health = 5
	randomTimer = RandomNumberGenerator.new()
	shootTimer = GlobalVariables.newTimer(interval, self, self, "shootTimerStopped")
	invincibleTimer = GlobalVariables.newTimer(0.75, self, self, "invincibleTimerStopped")
	shootTimer.start()
	
func missileHit():
	var randomVolume = rand_range(-2, 0)
	$hurtSound.set_volume_db(randomVolume)
	$hurtSound.play()
	GlobalVariables.score += 10	
	health -= 1
	if(health == 0):
		GlobalVariables.enemiesKilled += 1
		self.queue_free()
	else:
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite.set_modulate(Color(1, 0.1, 0.1, 1))
		invincibleTimer.start()
		
		
	if(GlobalVariables.score % 2000 == 0):
		GlobalVariables.lives += 1
		GlobalVariables.playerLives.set_text(str(GlobalVariables.lives))
	GlobalVariables.playerScore.set_text(str(GlobalVariables.score))

func shootTimerStopped():
	randomTimer.randomize()
	chance = randomTimer.randf_range(0, 100.0)
	
	if(chance > shootChanceMax - shootChanceMin):
		missile = EnemyMissileScene.instance()
	
		missile.position.x = self.global_position.x + 19
		missile.position.y = self.global_position.y + 39
	
		missile.add_to_group("homingMissiles")
	
		get_tree().get_root().add_child(missile)
	shootTimer.set_wait_time(interval)
	shootTimer.start()
	
func invincibleTimerStopped():
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite.set_modulate(Color(1, 1, 1, 1))
